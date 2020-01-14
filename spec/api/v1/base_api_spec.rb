require 'rails_helper'

RSpec.describe Cambada::V1::BaseAPI, type: :api do
  describe 'Configuration' do
    it 'has json format' do
      expect(described_class.format).to eq :json
    end

    it 'has v1 as version' do
      expect(described_class.version).to eq :v1
    end
  end

  describe 'Mounted apps' do
    subject { described_class.routes }

    describe 'Drafting Table apps' do
      it 'mounts Cambada::V1::DraftingTable::ProjectCategoriesAPI app' do
        is_expected.to include(*Cambada::V1::DraftingTable::ProjectCategoriesAPI.routes)
      end

      it 'mounts Cambada::V1::DraftingTable::ProjectSubcategoriesAPI app' do
        is_expected.to include(*Cambada::V1::DraftingTable::ProjectSubcategoriesAPI.routes)
      end
    end
  end

  describe 'Rescued errors' do
    subject { Class.new(described_class) }

    def app
      subject
    end

    context 'when ActiveRecord::RecordInvalid is raised' do
      before do
        subject.get '/example' do
          project_category = DraftingTable::ProjectCategory.new
          project_category.errors.add(:title, 'some error')
          raise ActiveRecord::RecordInvalid, project_category
        end
      end

      it 'formats params errors as json' do
        get '/v1/example'
        expect(response.body).to eq({ errors: { title: ['some error'] } }.to_json)
      end

      it 'responds with 422 http code' do
        get '/v1/example'
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when ActiveRecord::RecordNotDestroyed is raised' do
      before do
        subject.get '/example' do
          project_category = DraftingTable::ProjectCategory.new
          project_category.errors.add(:base, 'some error')
          raise ActiveRecord::RecordNotDestroyed.new('message', project_category)
        end
      end

      it 'formats params errors as json' do
        get '/v1/example'
        expect(response.body).to eq({ errors: { base: ['some error'] } }.to_json)
      end

      it 'responds with 409 http code' do
        get '/v1/example'
        expect(response).to have_http_status(:conflict)
      end
    end

    context 'when Grape::Exceptions::ValidationErrors is raised' do
      before do
        subject.params do
          requires :required_param, type: String
        end

        subject.get '/example' do
          raise Grape::Exceptions::ValidationErrors
        end
      end

      it 'formats params errors as json' do
        get '/v1/example'
        expect(response.body).to eq({ errors: ['required_param is missing'] }.to_json)
      end

      it 'responds with 400 http code' do
        get '/v1/example'
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when ActiveRecord::RecordNotFound is raised' do
      before do
        subject.get '/example' do
          raise ActiveRecord::RecordNotFound, 'not found'
        end
      end

      it 'format error as json' do
        get '/v1/example'
        expect(response.body).to eq({ error: 'not found' }.to_json)
      end

      it 'responds with 404 http code' do
        get '/v1/example'
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when an unexpected exception is raised' do
      before do
        subject.get '/example' do
          raise 'Some error'
        end
      end

      context 'when environment isn`t development' do
        it 'format error as json' do
          get '/v1/example'
          expect(response.body).to eq({ error: 'Internal server error' }.to_json)
        end

        it 'responds with 500 http code' do
          get '/v1/example'
          expect(response).to have_http_status(:server_error)
        end
      end

      context 'when environment is development' do
        it 'raises error' do
          Rails.env = 'development'
          expect { get '/v1/example' }.to raise_error(RuntimeError)
          Rails.env = 'test'
        end
      end

      context 'when environemnt is production' do
        it 'doesn`t raise error' do
          Rails.env = 'production'
          expect { get '/v1/example' }.to_not raise_error
          Rails.env = 'test'
        end
      end
    end
  end
end
