module DraftingTable
  class DestroyProjectSubcategory < Mutations::Command
    required do
      string :id
    end

    def execute
      project_subcategory = ProjectSubcategory.find(id)
      project_subcategory.destroy!
    end
  end
end
