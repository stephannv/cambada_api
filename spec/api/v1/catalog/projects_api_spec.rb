require 'rails_helper'

RSpec.describe Cambada::V1::Catalog::ProjectsAPI, type: :api do
  describe 'GET /v1/catalog/projects/:id' do
    let(:project) { build(:project, :with_fake_id) }

    before do
      allow(Catalog::FindProject).to receive(:call)
        .with(id: project.id)
        .and_return(double(project: project))
    end

    it 'has http status OK' do
      get '/v1/catalog/projects/' + project.id

      expect(response).to have_http_status(:ok)
    end

    it 'renders project category' do
      get '/v1/catalog/projects/' + project.id
      expected_response = {
        project: Catalog::ProjectEntity.new(project, type: :detailed)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'POST /v1/catalog/projects' do
    let(:project) { build(:project) }
    let(:params) do
      project.attributes.slice('title', 'project_type', 'short_description', 'project_subcategory_id').symbolize_keys
    end

    before do
      allow(Catalog::CreateProject).to receive(:call)
        .with(attributes: params)
        .and_return(double(project: project))
    end

    it 'has http status CREATED' do
      post '/v1/catalog/projects', params: { project: params }

      expect(response).to have_http_status(:created)
    end

    it 'renders newly created project category' do
      post '/v1/catalog/projects', params: { project: params }
      expected_response = {
        project: Catalog::ProjectEntity.new(project, type: :detailed)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'PUT /v1/catalog/projects/:id' do
    let(:project) { build(:project, :with_fake_id) }
    let(:params) { project.attributes.slice('title').symbolize_keys }

    before do
      allow(Catalog::UpdateProject).to receive(:call)
        .with(id: project.id, attributes: params)
        .and_return(double(project: project))
    end

    it 'has http status OK' do
      put "/v1/catalog/projects/#{project.id}", params: { project: params }
      expect(response).to have_http_status(:ok)
    end

    it 'renders the updated project category' do
      put "/v1/catalog/projects/#{project.id}", params: { project: params }
      expected_response = {
        project: Catalog::ProjectEntity.new(project, type: :detailed)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'DELETE /v1/catalog/projects/:id' do
    let(:project_id) { SecureRandom.uuid }

    before do
      expect(Catalog::DestroyProject).to receive(:call).with(id: project_id).and_return(result)
    end

    context 'when project can be destroyed' do
      let(:result) { double(success?: true) }

      it 'has http status NO_CONTENT' do
        delete "/v1/catalog/projects/#{project_id}"
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when project cannot be destroyed' do
      let(:result) { double(success?: false, message: 'some message') }

      it 'has http_status BAD_REQUEST' do
        delete "/v1/catalog/projects/#{project_id}"
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ error: 'some message' }.to_json)
      end
    end
  end
end
