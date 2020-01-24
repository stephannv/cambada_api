module Catalog
  class FindProjectSubcategory
    include Interactor

    def call
      context.project_subcategory = ProjectSubcategory.find(context.id)
    end
  end
end
