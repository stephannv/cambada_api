class CreateCatalogProjectCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :project_categories, id: :uuid do |t|
      t.string :title, null: false, index: { unique: true }, limit: 64
      t.string :slug, null: false, index: { unique: true }, limit: 128

      t.timestamps null: false
    end
  end
end
