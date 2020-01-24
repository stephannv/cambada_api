module Catalog
  class ProjectSubcategory < ApplicationRecord
    extend FriendlyId

    friendly_id :title, use: :slugged

    belongs_to :category,
      class_name: 'Catalog::ProjectCategory',
      foreign_key: :project_category_id,
      inverse_of: :subcategories

    has_many :projects, class_name: 'Catalog::Project', dependent: :restrict_with_exception

    validates :project_category_id, presence: true
    validates :title, presence: true
    validates :slug, presence: true

    validates :title, uniqueness: { case_sensitive: false, scope: :project_category_id }

    validates :title, length: { maximum: 64 }
    validates :slug, length: { maximum: 128 }

    def should_generate_new_friendly_id?
      title_changed? || super
    end
  end
end
