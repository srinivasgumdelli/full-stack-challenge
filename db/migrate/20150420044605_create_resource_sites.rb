class CreateResourceSites < ActiveRecord::Migration
  def change
    create_table :resource_sites do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :address, null: false

      t.timestamps null: false
    end
  end
end
