require 'rails_helper'

RSpec.describe Catalog::FindProjectCategory, type: :interactor do
  describe 'Behavior' do
    context 'when project category with given id exists' do
      let!(:project_category) { create(:project_category) }

      it 'returns the project category' do
        result = described_class.call(id: project_category.id)
        expect(result.project_category).to eq project_category
      end
    end

    context 'when project category with given id doesn`t exist' do
      it 'raises RecordNotFound error' do
        expect { described_class.call(id: 'fake-id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
