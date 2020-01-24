module Catalog
  class FindProjectCategory
    include Interactor

    def call
      context.project_category = Catalog::ProjectCategory.find(context.id)
    end
  end
end
