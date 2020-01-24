require 'rails_helper'

RSpec.describe Catalog::ProjectCategoryEntity, type: :entity do
  let(:resource) { build(:project_category, :with_fake_id) }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  describe 'Exposures' do
    it 'exposes id' do
      expect(serializable_hash[:id]).to eq resource.id
    end

    it 'exposes title' do
      expect(serializable_hash[:title]).to eq resource.title
    end

    it 'exposes slug' do
      expect(serializable_hash[:slug]).to eq resource.slug
    end

    context 'when type is detailed' do
      let(:subcategories) { build_list(:project_subcategory, 3) }
      let(:serializable_hash) { described_class.new(resource, type: :detailed).serializable_hash }
      let(:subcategories_hash) do
        Catalog::ProjectSubcategoryEntity.represent(subcategories, except: [:category]).map(&:serializable_hash)
      end

      before { allow(resource).to receive_message_chain('subcategories.order').with(:title).and_return(subcategories) }

      it 'exposes project subcategories' do
        expect(serializable_hash[:subcategories]).to eq subcategories_hash
      end
    end

    context 'when type isn`t detailed' do
      it 'doesn`t expose project subcategories' do
        expect(serializable_hash[:subcategories]).to be_nil
      end
    end
  end
end
