module DraftingTable
  class UpdateProjectCategory < Mutations::Command
    required do
      string :id
      hash :attributes do
        required do
          string :title, empty: true
        end
      end
    end

    def execute
      project_category = ProjectCategory.find(id)
      project_category.update!(attributes)
      project_category
    end
  end
end
