module DraftingTable
  class FindProjectSubcategory < Mutations::Command
    required do
      string :id
    end

    def execute
      ProjectSubcategory.find(id)
    end
  end
end
