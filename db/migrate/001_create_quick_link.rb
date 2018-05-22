class CreateQuickLink < ActiveRecord::Migration[5.1]
  def change
    create_table :quick_link do |t|
      t.string :label
      t.text :description
      t.text :link
      t.string :icon_class
      t.integer :project_id
      t.integer :role_id
    end
  end
end
