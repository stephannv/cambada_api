module DraftingTable
  class UpdateProjectSubcategory < Mutations::Command
    required do
      string :id
      hash :attributes do
        required do
          string :title, empty: true
        end
      end
    end

    def execute
      project_subcategory = ProjectSubcategory.find(id)
      project_subcategory.update!(attributes)
      project_subcategory
    end
  end
end
