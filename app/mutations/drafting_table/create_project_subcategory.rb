module DraftingTable
  class CreateProjectSubcategory < Mutations::Command
    required do
      hash :attributes do
        string :project_category_id, empty: true
        string :title, empty: true
      end
    end

    def execute
      ProjectSubcategory.create!(attributes)
    end
  end
end
