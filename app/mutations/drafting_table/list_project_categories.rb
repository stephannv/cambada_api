module DraftingTable
  class ListProjectCategories < Mutations::Command
    def execute
      ProjectCategory.order(:title).all
    end
  end
end
