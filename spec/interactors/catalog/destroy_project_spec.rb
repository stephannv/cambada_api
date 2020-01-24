require 'rails_helper'

RSpec.describe Catalog::DestroyProject, type: :interactor do
  describe '.call' do
    context 'when project with given id exists' do
      context 'when project is a draft' do
        let!(:project) { create(:project, state: :draft) }

        it 'destroys the project' do
          expect do
            described_class.call(id: project.id)
          end.to change(Catalog::Project, :count).by(-1)

          expect { project.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when project isn`t a draft' do
        let(:state) { (Catalog::Project.aasm.states.map(&:name) - [:draft]).sample }
        let!(:project) { create(:project, state: state) }

        it 'fails' do
          result = described_class.call(id: project.id)
          expect(result).to be_failure
          expect(result.message).to eq 'A project cannot be deleted after going live'
          expect { project.reload }.to_not raise_error
        end
      end
    end

    context 'when project with given id doesn`t exist' do
      it 'raises an error' do
        expect { described_class.call(id: 'fake-id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
