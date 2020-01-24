module Catalog
  class ProjectEntity < ::BaseEntity
    expose :id
    expose :title
    expose :slug
    expose :subcategory, using: Catalog::ProjectSubcategoryEntity
    expose :project_type
    expose :state
    expose :short_description
    expose :full_description

    with_options format_with: :iso_timestamp do
      expose :deadline
    end
  end
end
