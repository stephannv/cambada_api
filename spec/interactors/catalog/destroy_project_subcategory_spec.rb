require 'rails_helper'

RSpec.describe Catalog::DestroyProjectSubcategory, type: :interactor do
  describe 'Behavior' do
    context 'when project subcategory with given id exists' do
      let!(:project_subcategory) { create(:project_subcategory) }

      it 'destroys the project subcategory' do
        expect do
          described_class.call(id: project_subcategory.id)
        end.to change(Catalog::ProjectSubcategory, :count).by(-1)

        expect { project_subcategory.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when project subcategory with given id doesn`t exist' do
      it 'raises RecordNotFound error' do
        expect { described_class.call(id: 'fake-id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
