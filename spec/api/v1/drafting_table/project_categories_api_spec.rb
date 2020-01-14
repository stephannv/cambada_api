require 'rails_helper'

RSpec.describe Cambada::V1::DraftingTable::ProjectCategoriesAPI, type: :api do
  describe 'GET /v1/drafting_table/project_categories' do
    let(:project_category) { build(:project_category) }

    before do
      allow(DraftingTable::ListProjectCategories).to receive(:run!)
        .and_return([project_category])
    end

    it 'has http status OK' do
      get '/v1/drafting_table/project_categories'

      expect(response).to have_http_status(:ok)
    end

    it 'renders project categories' do
      get '/v1/drafting_table/project_categories'
      expected_response = {
        project_categories: [DraftingTable::ProjectCategoryEntity.new(project_category)]
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'GET /v1/drafting_table/project_categories/:id' do
    let(:project_category) { build(:project_category, :with_fake_id) }

    before do
      allow(DraftingTable::FindProjectCategory).to receive(:run!)
        .with(id: project_category.id)
        .and_return(project_category)
    end

    it 'has http status OK' do
      get '/v1/drafting_table/project_categories/' + project_category.id

      expect(response).to have_http_status(:ok)
    end

    it 'renders project category' do
      get '/v1/drafting_table/project_categories/' + project_category.id
      expected_response = {
        project_category: DraftingTable::ProjectCategoryEntity.new(project_category, type: :detailed)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'POST /v1/drafting_table/project_categories' do
    let(:project_category) { build(:project_category) }
    let(:params) { project_category.attributes.slice('title').symbolize_keys }

    before do
      allow(DraftingTable::CreateProjectCategory).to receive(:run!)
        .with(attributes: params)
        .and_return(project_category)
    end

    it 'has http status CREATED' do
      post '/v1/drafting_table/project_categories', params: { project_category: params }

      expect(response).to have_http_status(:created)
    end

    it 'renders newly created project category' do
      post '/v1/drafting_table/project_categories', params: { project_category: params }
      expected_response = {
        project_category: DraftingTable::ProjectCategoryEntity.new(project_category, type: :detailed)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'PUT /v1/drafting_table/project_categories/:id' do
    let(:project_category) { build(:project_category, :with_fake_id) }
    let(:params) { project_category.attributes.slice('title').symbolize_keys }

    before do
      allow(DraftingTable::UpdateProjectCategory).to receive(:run!)
        .with(id: project_category.id, attributes: params)
        .and_return(project_category)
    end

    it 'has http status OK' do
      put "/v1/drafting_table/project_categories/#{project_category.id}", params: { project_category: params }
      expect(response).to have_http_status(:ok)
    end

    it 'renders the updated project category' do
      put "/v1/drafting_table/project_categories/#{project_category.id}", params: { project_category: params }
      expected_response = {
        project_category: DraftingTable::ProjectCategoryEntity.new(project_category, type: :detailed)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'DELETE /v1/drafting_table/project_categories/:id' do
    let(:project_category_id) { SecureRandom.uuid }

    before do
      expect(DraftingTable::DestroyProjectCategory).to receive(:run!).with(id: project_category_id)
    end

    it 'has http status NO_CONTENT' do
      delete "/v1/drafting_table/project_categories/#{project_category_id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
