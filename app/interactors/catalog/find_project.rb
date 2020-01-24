module Catalog
  class FindProject
    include Interactor

    def call
      context.project = Catalog::Project.find(context.id)
    end
  end
end
