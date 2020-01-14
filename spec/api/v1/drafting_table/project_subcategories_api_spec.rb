require 'rails_helper'

RSpec.describe Cambada::V1::DraftingTable::ProjectSubcategoriesAPI, type: :api do
  describe 'GET /v1/drafting_table/project_subcategories/:id' do
    let(:project_subcategory) { build(:project_subcategory, :with_fake_id) }

    before do
      allow(DraftingTable::FindProjectSubcategory).to receive(:run!)
        .with(id: project_subcategory.id)
        .and_return(project_subcategory)
    end

    it 'has http status OK' do
      get '/v1/drafting_table/project_subcategories/' + project_subcategory.id

      expect(response).to have_http_status(:ok)
    end

    it 'renders project subcategory' do
      get '/v1/drafting_table/project_subcategories/' + project_subcategory.id
      expected_response = {
        project_subcategory: DraftingTable::ProjectSubcategoryEntity.new(project_subcategory)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'POST /v1/drafting_table/project_subcategories' do
    let(:project_subcategory) { build(:project_subcategory, category: create(:project_category)) }
    let(:params) { project_subcategory.attributes.slice('title', 'project_category_id').symbolize_keys }

    before do
      allow(DraftingTable::CreateProjectSubcategory).to receive(:run!)
        .with(attributes: params)
        .and_return(project_subcategory)
    end

    it 'has http status CREATED' do
      post '/v1/drafting_table/project_subcategories', params: { project_subcategory: params }

      expect(response).to have_http_status(:created)
    end

    it 'renders newly created project subcategory' do
      post '/v1/drafting_table/project_subcategories', params: { project_subcategory: params }
      expected_response = {
        project_subcategory: DraftingTable::ProjectSubcategoryEntity.new(project_subcategory, type: :detailed)
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end

  describe 'PUT /v1/drafting_table/project_subcategories/:id' do
    let(:project_subcategory) { build(:project_subcategory, :with_fake_id) }
    let(:params) { project_subcategory.attributes.slice('title').symbolize_keys }

    before do
      allow(DraftingTable::UpdateProjectSubcategory).to receive(:run!)
        .with(id: project_subcategory.id, attributes: params)
        .and_return(project_subcategory)
    end

    it 'has http status OK' do
      put "/v1/drafting_table/project_subcategories/#{project_subcategory.id}", params: { project_subcategory: params }
      expect(response).to have_http_status(:ok)
    end

    it 'renders the updated project subcategory' do
      put "/v1/drafting_table/project_subcategories/#{project_subcategory.id}", params: { project_subcategory: params }
      expected_response = {
        project_subcategory: DraftingTable::ProjectSubcategoryEntity.new(project_subcategory, type: :detailed)
      }.to_json

      expect(response.body).to eq expected_response
    end
  end

  describe 'DELETE /v1/drafting_table/project_subcategories/:id' do
    let(:project_subcategory_id) { SecureRandom.uuid }

    before do
      expect(DraftingTable::DestroyProjectSubcategory).to receive(:run!).with(id: project_subcategory_id)
    end

    it 'has http status NO_CONTENT' do
      delete "/v1/drafting_table/project_subcategories/#{project_subcategory_id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
