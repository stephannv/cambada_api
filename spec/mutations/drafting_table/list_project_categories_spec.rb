require 'rails_helper'

RSpec.describe DraftingTable::ListProjectCategories, type: :mutation do
  describe 'Behavior' do
    let!(:project_category_1) { create(:project_category, title: 'C') }
    let!(:project_category_2) { create(:project_category, title: 'A') }
    let!(:project_category_3) { create(:project_category, title: 'B') }

    it 'returns all project categories ordered by title' do
      outcome = described_class.run
      expect(outcome.result).to include(project_category_1, project_category_2, project_category_3)
      expect(outcome.result.first).to eq project_category_2
      expect(outcome.result.last).to eq project_category_1
    end
  end
end
