module Catalog
  class ProjectCategoryEntity < ::BaseEntity
    expose :id
    expose :title
    expose :slug
    expose :subcategories, if: { type: :detailed } do |project_category, _options|
      ProjectSubcategoryEntity.represent(project_category.subcategories.order(:title), except: [:category])
    end
  end
end
