class CreateCollaborators < ActiveRecord::Migration[8.0]
  def change
    create_table :collaborators do |t|
      t.string :permission

      t.timestamps
    end
  end
end
