require 'rails_helper'

RSpec.describe DraftingTable::FindProjectSubcategory, type: :mutation do
  describe 'Behavior' do
    context 'when project subcategory with given id exists' do
      let!(:project_subcategory) { create(:project_subcategory) }

      it 'returns the project subcategory' do
        outcome = described_class.run(id: project_subcategory.id)
        expect(outcome.result).to eq project_subcategory
      end
    end

    context 'when project subcategory with given id doesn`t exist' do
      it 'raises RecordNotFound error' do
        expect { described_class.run(id: 'fake-id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
