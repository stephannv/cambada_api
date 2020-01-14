require 'rails_helper'

RSpec.describe DraftingTable::FindProjectCategory, type: :mutation do
  describe 'Behavior' do
    context 'when project category with given id exists' do
      let!(:project_category) { create(:project_category) }

      it 'returns the project category' do
        outcome = described_class.run(id: project_category.id)
        expect(outcome.result).to eq project_category
      end
    end

    context 'when project category with given id doesn`t exist' do
      it 'raises RecordNotFound error' do
        expect { described_class.run(id: 'fake-id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
