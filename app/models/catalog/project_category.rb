module Catalog
  class ProjectCategory < ApplicationRecord
    extend FriendlyId

    friendly_id :title, use: :slugged

    has_many :projects, through: :subcategories
    has_many :subcategories, class_name: 'Catalog::ProjectSubcategory', dependent: :destroy

    validates :title, presence: true
    validates :slug, presence: true

    validates :title, uniqueness: { case_sensitive: false }

    validates :title, length: { maximum: 64 }
    validates :slug, length: { maximum: 128 }

    def should_generate_new_friendly_id?
      title_changed? || super
    end
  end
end
