class CreateCatalogProjectSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :project_subcategories, id: :uuid do |t|
      t.references :project_category, index: true, null: false, type: :uuid, foreign_key: true
      t.string :title, null: false, limit: 64
      t.string :slug, null: false, limit: 128

      t.timestamps null: false
    end

    add_index :project_subcategories, %i[project_category_id title], unique: true
    add_index :project_subcategories, %i[project_category_id slug], unique: true
  end
end
