class CreateQuickLinks < ActiveRecord::Migration
  def change
    create_table :quick_links do |t|
      t.string :label
      t.text :description
      t.text :url
      t.string :icon_class
      t.integer :project_id
      t.integer :role_id
    end
  end
end
