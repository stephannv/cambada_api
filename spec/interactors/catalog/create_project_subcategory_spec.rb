require 'rails_helper'

RSpec.describe Catalog::CreateProjectSubcategory, type: :interactor do
  describe '.call' do
    subject(:result) { described_class.call(attributes: attributes) }

    context 'when attributes are valid' do
      let(:project_category) { create(:project_category) }
      let(:attributes) { { project_category_id: project_category.id, title: 'New Subcategory' } }

      it 'creates a new project subcategory' do
        expect { result }.to change(project_category.subcategories, :count).by(1)
        expect(result.project_subcategory).to be_persisted
        expect(result.project_subcategory).to be_a(Catalog::ProjectSubcategory)
        expect(result.project_subcategory.category).to eq project_category
        expect(result.project_subcategory.title).to eq 'New Subcategory'
        expect(result.project_subcategory.slug).to eq 'new-subcategory'
      end
    end

    context 'when attributes are invalid' do
      let(:attributes) { { project_category_id: '', title: '' } }

      it 'raises RecordInvalid error' do
        expect { result }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
