require 'rails_helper'

RSpec.describe DraftingTable::UpdateProjectSubcategory, type: :mutation do
  describe 'Behavior' do
    context 'when project subcategory with given id exists' do
      let(:project_subcategory) { create(:project_subcategory, title: 'Old title') }
      let(:outcome) { described_class.run(id: project_subcategory.id, attributes: attributes) }

      context 'with valid attributes' do
        let(:attributes) { { title: 'Updated title' } }

        it 'updates the project subcategory' do
          expect(outcome.result.reload.title).to eq 'Updated title'
          expect(outcome.result.reload.slug).to eq 'updated-title'
        end
      end

      context 'with invalid attributes' do
        let(:attributes) { { title: '' } }

        it 'raises RecordInvalid error' do
          expect { outcome }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context 'when project subcategory with given id doesn`t exist' do
      it 'raises RecordNotFound error' do
        expect do
          described_class.run(id: 'fake-id', attributes: { title: '' })
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
