module Catalog
  class DestroyProject
    include Interactor

    def call
      project = Project.find(context.id)

      if project.draft?
        project.destroy!
      else
        context.fail!(message: 'A project cannot be deleted after going live')
      end
    end
  end
end
