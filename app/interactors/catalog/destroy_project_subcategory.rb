module Catalog
  class DestroyProjectSubcategory
    include Interactor

    def call
      project_subcategory = ProjectSubcategory.find(context.id)
      project_subcategory.destroy!
    end
  end
end
