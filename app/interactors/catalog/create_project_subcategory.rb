module Catalog
  class CreateProjectSubcategory
    include Interactor

    def call
      context.project_subcategory = ProjectSubcategory.create!(context.attributes)
    end
  end
end
