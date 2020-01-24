class CreateCatalogProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.references :project_subcategory, null: false, foreign_key: true, type: :uuid, index: true
      t.string :project_type, null: false, index: true
      t.string :state, null: false, index: true
      t.string :slug, null: false, index: { unique: true }, limit: 200
      t.string :title, null: false, limit: 80, index: { unique: true }
      t.string :short_description, limit: 255
      t.text :full_description
      t.datetime :deadline, precision: 6

      t.timestamps null: false
    end
  end
end
