module Catalog
  class UpdateProjectCategory
    include Interactor

    def call
      context.project_category = ProjectCategory.find(context.id)
      context.project_category.update!(context.attributes)
    end
  end
end
