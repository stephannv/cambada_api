require 'rails_helper'

RSpec.describe DraftingTable::ProjectSubcategoryEntity, type: :entity do
  let(:resource) { build(:project_subcategory, :with_fake_id) }
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

    it 'exposes category' do
      category_hash = DraftingTable::ProjectCategoryEntity.represent(resource.category).serializable_hash
      expect(serializable_hash[:category]).to eq category_hash
    end
  end
end
