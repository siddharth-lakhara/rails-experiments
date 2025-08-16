class CreateResources < ActiveRecord::Migration[8.0]
  def change
    create_table :resources, id: :uuid do |t|
      t.string :description, null: false
      t.references :owner, type: :uuid, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
