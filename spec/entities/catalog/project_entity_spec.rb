require 'rails_helper'

RSpec.describe Catalog::ProjectEntity, type: :entity do
  let(:resource) { build(:project, :with_fake_id, :all_or_nothing, subcategory: create(:project_subcategory)) }
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

    it 'exposes subcategory' do
      subcategory_hash = Catalog::ProjectSubcategoryEntity.represent(resource.subcategory).serializable_hash
      expect(serializable_hash[:subcategory]).to eq subcategory_hash
    end

    it 'exposes project_type' do
      expect(serializable_hash[:project_type]).to eq resource.project_type
    end

    it 'exposes short_description' do
      expect(serializable_hash[:short_description]).to eq resource.short_description
    end

    it 'exposes full_description' do
      expect(serializable_hash[:full_description]).to eq resource.full_description
    end

    it 'exposes deadline' do
      expect(serializable_hash[:deadline]).to eq resource.deadline.try(:iso8601)
    end
  end
end
