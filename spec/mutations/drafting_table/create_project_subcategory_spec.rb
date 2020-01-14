require 'rails_helper'

RSpec.describe DraftingTable::CreateProjectSubcategory, type: :mutation do
  describe 'Behavior' do
    let(:outcome) { described_class.run(attributes: attributes) }

    context 'when attributes are valid' do
      let(:project_category) { create(:project_category) }
      let(:attributes) { { project_category_id: project_category.id, title: 'New Subcategory' } }

      it 'creates a new project subcategory' do
        expect { outcome }.to change(project_category.subcategories, :count).by(1)
        expect(outcome.result).to be_persisted
        expect(outcome.result).to be_a(DraftingTable::ProjectSubcategory)
        expect(outcome.result.category).to eq project_category
        expect(outcome.result.title).to eq 'New Subcategory'
        expect(outcome.result.slug).to eq 'new-subcategory'
      end
    end

    context 'when attributes are invalid' do
      let(:attributes) { { project_category_id: '', title: '' } }

      it 'raises RecordInvalid error' do
        expect { outcome }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
