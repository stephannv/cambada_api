require 'rails_helper'

RSpec.describe Cambada::V1::Catalog::ProjectSubcategoriesAPI, type: :api do
  describe 'GET /v1/catalog/project_subcategories/:id' do
    let(:project_subcategory) { build(:project_subcategory, :with_fake_id) }

    before do
      allow(Catalog::FindProjectSubcategory).to receive(:call)
        .with(id: project_subcategory.id)
        .and_return(double(project_subcategory: project_subcategory))
    end

    it 'has http status OK' do
      get '/v1/catalog/project_subcategories/' + project_subcategory.id

      expect(response).to have_http_status(:ok)
    end

    it 'renders project subcategory' do
      get '/v1/catalog/project_subcategories/' + project_subcategory.id
      expected_response = {
        project_subcategory: Catalog::ProjectSubcategoryEntity.new(project_subcategory)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'POST /v1/catalog/project_subcategories' do
    let(:project_subcategory) { build(:project_subcategory, category: create(:project_category)) }
    let(:params) { project_subcategory.attributes.slice('title', 'project_category_id').symbolize_keys }

    before do
      allow(Catalog::CreateProjectSubcategory).to receive(:call)
        .with(attributes: params)
        .and_return(double(project_subcategory: project_subcategory))
    end

    it 'has http status CREATED' do
      post '/v1/catalog/project_subcategories', params: { project_subcategory: params }

      expect(response).to have_http_status(:created)
    end

    it 'renders newly created project subcategory' do
      post '/v1/catalog/project_subcategories', params: { project_subcategory: params }
      expected_response = {
        project_subcategory: Catalog::ProjectSubcategoryEntity.new(project_subcategory, type: :detailed)
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end

  describe 'PUT /v1/catalog/project_subcategories/:id' do
    let(:project_subcategory) { build(:project_subcategory, :with_fake_id) }
    let(:params) { project_subcategory.attributes.slice('title').symbolize_keys }

    before do
      allow(Catalog::UpdateProjectSubcategory).to receive(:call)
        .with(id: project_subcategory.id, attributes: params)
        .and_return(double(project_subcategory: project_subcategory))
    end

    it 'has http status OK' do
      put "/v1/catalog/project_subcategories/#{project_subcategory.id}", params: { project_subcategory: params }
      expect(response).to have_http_status(:ok)
    end

    it 'renders the updated project subcategory' do
      put "/v1/catalog/project_subcategories/#{project_subcategory.id}", params: { project_subcategory: params }
      expected_response = {
        project_subcategory: Catalog::ProjectSubcategoryEntity.new(project_subcategory, type: :detailed)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'DELETE /v1/catalog/project_subcategories/:id' do
    let(:project_subcategory_id) { SecureRandom.uuid }

    before do
      expect(Catalog::DestroyProjectSubcategory).to receive(:call).with(id: project_subcategory_id)
    end

    it 'has http status NO_CONTENT' do
      delete "/v1/catalog/project_subcategories/#{project_subcategory_id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
