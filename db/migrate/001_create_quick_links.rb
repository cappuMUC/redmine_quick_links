class CreateQuickLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :quick_links do |t|
      t.string :label
      t.text :description
      t.text :url
      t.string :icon_class
      t.integer :project_id
      t.integer :role_id
      t.integer :position, :default => 1
    end
  end
end
