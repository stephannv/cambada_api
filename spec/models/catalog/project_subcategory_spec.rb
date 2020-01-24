require 'rails_helper'

RSpec.describe Catalog::ProjectSubcategory, type: :model do
  describe 'Relations' do
    it do
      is_expected.to belong_to(:category)
        .class_name('Catalog::ProjectCategory')
        .with_foreign_key(:project_category_id)
    end
  end

  describe 'Indexes' do
    it { is_expected.to have_db_index(:project_category_id) }
    it { is_expected.to have_db_index(%i[project_category_id title]).unique(true) }
    it { is_expected.to have_db_index(%i[project_category_id slug]).unique(true) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:project_category_id) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:slug) }

    it do
      create(:project_subcategory)
      is_expected.to validate_uniqueness_of(:title).case_insensitive.scoped_to(:project_category_id)
    end

    it { is_expected.to validate_length_of(:title).is_at_most(64) }
    it { is_expected.to validate_length_of(:slug).is_at_most(128) }
  end
end
