require 'rails_helper'

RSpec.describe Catalog::UpdateProject, type: :interactor do
  describe 'Behavior' do
    context 'when project with given id exists' do
      subject(:result) { described_class.call(id: project.id, attributes: attributes) }

      let(:project) { create(:project, title: 'Old title') }

      context 'with valid attributes' do
        let(:attributes) { { title: 'Updated title' } }

        it 'updates the project' do
          expect(result.project.reload.title).to eq 'Updated title'
          expect(result.project.reload.slug).to eq 'updated-title'
        end
      end

      context 'with invalid attributes' do
        let(:attributes) { { title: '' } }

        it 'raises RecordInvalid error' do
          expect { result }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context 'when project with given id doesn`t exist' do
      it 'raises RecordNotFound error' do
        expect do
          described_class.call(id: 'fake-id', attributes: { title: '' })
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
