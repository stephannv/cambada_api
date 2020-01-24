require 'rails_helper'

RSpec.describe Catalog::Project, type: :model do
  describe 'Relations' do
    it do
      is_expected.to belong_to(:subcategory)
        .class_name('Catalog::ProjectSubcategory')
        .with_foreign_key(:project_subcategory_id)
    end

    it do
      is_expected.to have_many(:state_transitions)
        .class_name('Catalog::ProjectStateTransition')
        .dependent(:destroy)
    end
  end

  describe 'Indexes' do
    it { is_expected.to have_db_index(:project_subcategory_id).unique(false) }
    it { is_expected.to have_db_index(:slug).unique(true) }
    it { is_expected.to have_db_index(:project_type).unique(false) }
    it { is_expected.to have_db_index(:state).unique(false) }
    it { is_expected.to have_db_index(:title).unique(true) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:project_subcategory_id) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:project_type) }
    it { is_expected.to validate_presence_of(:state) }

    it do
      create(:project)
      is_expected.to validate_uniqueness_of(:title).case_insensitive
    end

    it { is_expected.to validate_length_of(:title).is_at_most(80) }
    it { is_expected.to validate_length_of(:slug).is_at_most(200) }
    it { is_expected.to validate_length_of(:short_description).is_at_most(255) }
    it { is_expected.to validate_length_of(:full_description).is_at_most(8192) }

    context 'when is subscription' do
      before { subject.project_type = 'subscription' }

      it { is_expected.to validate_absence_of(:deadline) }
    end

    context 'when isn`t subscription' do
      (described_class.project_types.values - ['subscription']).each do |project_type|
        before { subject.project_type = project_type }

        it { is_expected.to_not validate_absence_of(:deadline) }
      end
    end
  end
end
