module Catalog
  class UpdateProject
    include Interactor

    def call
      context.project = Project.find(context.id)
      context.project.update!(context.attributes)
    end
  end
end
