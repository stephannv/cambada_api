module Catalog
  class ListProjectCategories
    include Interactor

    def call
      context.project_categories = ProjectCategory.order(:title).all
    end
  end
end
