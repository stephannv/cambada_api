require 'rails_helper'

RSpec.describe Catalog::FindProjectSubcategory, type: :interactor do
  describe 'Behavior' do
    context 'when project subcategory with given id exists' do
      let!(:project_subcategory) { create(:project_subcategory) }

      it 'returns the project subcategory' do
        result = described_class.call(id: project_subcategory.id)
        expect(result.project_subcategory).to eq project_subcategory
      end
    end

    context 'when project subcategory with given id doesn`t exist' do
      it 'raises RecordNotFound error' do
        expect { described_class.call(id: 'fake-id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
