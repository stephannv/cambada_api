require 'rails_helper'

RSpec.describe Catalog::ProjectCategory, type: :model do
  describe 'Relations' do
    it { is_expected.to have_many(:subcategories).class_name('Catalog::ProjectSubcategory').dependent(:destroy) }
  end

  describe 'Indexes' do
    it { is_expected.to have_db_index(:title).unique(true) }
    it { is_expected.to have_db_index(:slug).unique(true) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:slug) }

    it do
      create(:project_category)
      is_expected.to validate_uniqueness_of(:title).case_insensitive
    end

    it { is_expected.to validate_length_of(:title).is_at_most(64) }
    it { is_expected.to validate_length_of(:slug).is_at_most(128) }
  end
end
