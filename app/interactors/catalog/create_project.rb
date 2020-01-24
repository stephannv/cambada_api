module Catalog
  class CreateProject
    include Interactor

    def call
      context.project = Catalog::Project.create!(context.attributes)
    end
  end
end
