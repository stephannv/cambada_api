require 'rails_helper'

RSpec.describe DraftingTable::DestroyProjectCategory, type: :mutation do
  describe 'Behavior' do
    context 'when project category with given id exists' do
      let!(:project_category) { create(:project_category) }

      it 'destroys the project category' do
        expect do
          described_class.run(id: project_category.id)
        end.to change(DraftingTable::ProjectCategory, :count).by(-1)

        expect { project_category.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when project category with given id doesn`t exist' do
      it 'raises an error' do
        expect { described_class.run(id: 'fake-id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
