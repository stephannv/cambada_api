require 'rails_helper'

RSpec.describe Catalog::CreateProjectCategory, type: :interactor do
  describe '.call' do
    subject(:result) { described_class.call(attributes: attributes) }

    context 'when attributes are valid' do
      let(:attributes) { { title: 'New Category' } }

      it 'creates a new project category' do
        expect { result }.to change(Catalog::ProjectCategory, :count).by(1)
        expect(result).to be_a_success
        expect(result.project_category).to be_persisted
        expect(result.project_category).to be_a(Catalog::ProjectCategory)
        expect(result.project_category.title).to eq 'New Category'
        expect(result.project_category.slug).to eq 'new-category'
      end
    end

    context 'when attributes are invalid' do
      let(:attributes) { { title: '' } }

      it 'raises RecordInvalid error' do
        expect { result }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
