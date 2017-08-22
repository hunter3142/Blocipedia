class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
    	t.references :wiki, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
    add_foreign_key :collaborators, :wikis
    add_foreign_key :collaborators, :users
  end
end
