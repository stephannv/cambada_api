module Catalog
  class CreateProjectCategory
    include Interactor

    def call
      context.project_category = ProjectCategory.create!(context.attributes)
    end
  end
end
