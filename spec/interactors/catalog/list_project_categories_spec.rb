require 'rails_helper'

RSpec.describe Catalog::ListProjectCategories, type: :interactor do
  describe 'Behavior' do
    let!(:project_category_1) { create(:project_category, title: 'C') }
    let!(:project_category_2) { create(:project_category, title: 'A') }
    let!(:project_category_3) { create(:project_category, title: 'B') }

    it 'returns all project categories ordered by title' do
      result = described_class.call
      expect(result.project_categories).to include(project_category_1, project_category_2, project_category_3)
      expect(result.project_categories.first).to eq project_category_2
      expect(result.project_categories.last).to eq project_category_1
    end
  end
end
