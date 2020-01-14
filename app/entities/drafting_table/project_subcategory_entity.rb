module DraftingTable
  class ProjectSubcategoryEntity < Grape::Entity
    expose :id
    expose :title
    expose :slug
    expose :category do |project_subcategory, _options|
      ProjectCategoryEntity.represent project_subcategory.category, except: [:subcategories]
    end
  end
end
