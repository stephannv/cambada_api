module DraftingTable
  class DestroyProjectCategory < Mutations::Command
    required do
      string :id
    end

    def execute
      project_category = ProjectCategory.find(id)
      project_category.destroy!
    end
  end
end
