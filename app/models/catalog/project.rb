module Catalog
  class Project < ApplicationRecord
    extend FriendlyId
    include Catalog::Concerns::ProjectStateMachine

    friendly_id :title, use: :slugged

    as_enum :project_type, %i[all_or_nothing flexible subscription], map: :string, source: :project_type

    belongs_to :subcategory,
      class_name: 'Catalog::ProjectSubcategory',
      foreign_key: :project_subcategory_id,
      inverse_of: :projects

    has_many :state_transitions, class_name: 'Catalog::ProjectStateTransition', dependent: :destroy

    validates :project_subcategory_id, presence: true
    validates :title, presence: true
    validates :slug, presence: true
    validates :project_type, presence: true
    validates :state, presence: true

    validates :title, uniqueness: { case_sensitive: false }

    validates :title, length: { maximum: 80 }
    validates :slug, length: { maximum: 200 }
    validates :short_description, length: { maximum: 255 }
    validates :full_description, length: { maximum: 8192 }

    validates :deadline, absence: true, if: :subscription?

    def should_generate_new_friendly_id?
      title_changed? || super
    end
  end
end
