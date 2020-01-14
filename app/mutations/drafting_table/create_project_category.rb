module DraftingTable
  class CreateProjectCategory < Mutations::Command
    required do
      hash :attributes do
        string :title, empty: true
      end
    end

    def execute
      ProjectCategory.create!(attributes)
    end
  end
end
