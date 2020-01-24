class CreateCatalogProjectStateTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :project_state_transitions, id: :uuid do |t|
      t.references :project, null: false, foreign_key: true, type: :uuid, index: true
      t.string :from_state, limit: 50
      t.string :to_state, null: false, limit: 50
      t.string :event, limit: 50
      t.boolean :most_recent

      t.timestamps null: false
    end
  end
end
