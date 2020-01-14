require 'rails_helper'

RSpec.describe DraftingTable::CreateProjectCategory, type: :mutation do
  describe 'Behavior' do
    let(:outcome) { described_class.run(attributes: attributes) }

    context 'when attributes are valid' do
      let(:attributes) { { title: 'New Category' } }

      it 'creates a new project category' do
        expect { outcome }.to change(DraftingTable::ProjectCategory, :count).by(1)
        expect(outcome.result).to be_persisted
        expect(outcome.result).to be_a(DraftingTable::ProjectCategory)
        expect(outcome.result.title).to eq 'New Category'
        expect(outcome.result.slug).to eq 'new-category'
      end
    end

    context 'when attributes are invalid' do
      let(:attributes) { { title: '' } }

      it 'raises RecordInvalid error' do
        expect { outcome }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
