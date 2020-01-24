module Catalog
  class DestroyProjectCategory
    include Interactor

    def call
      project_category = ProjectCategory.find(context.id)
      project_category.destroy!
    end
  end
end
