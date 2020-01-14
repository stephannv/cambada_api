module DraftingTable
  class FindProjectCategory < Mutations::Command
    required do
      string :id
    end

    def execute
      ProjectCategory.find(id)
    end
  end
end
