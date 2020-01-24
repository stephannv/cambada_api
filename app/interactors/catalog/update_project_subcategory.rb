module Catalog
  class UpdateProjectSubcategory
    include Interactor

    def call
      context.project_subcategory = ProjectSubcategory.find(context.id)
      context.project_subcategory.update!(context.attributes)
    end
  end
end
