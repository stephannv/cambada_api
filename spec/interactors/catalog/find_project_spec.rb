require 'rails_helper'

RSpec.describe Catalog::FindProject, type: :interactor do
  describe 'Behavior' do
    context 'when project with given id exists' do
      let!(:project) { create(:project) }

      it 'returns the project' do
        result = described_class.call(id: project.id)
        expect(result.project).to eq project
      end
    end

    context 'when project with given id doesn`t exist' do
      it 'raises RecordNotFound error' do
        expect { described_class.call(id: 'fake-id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
