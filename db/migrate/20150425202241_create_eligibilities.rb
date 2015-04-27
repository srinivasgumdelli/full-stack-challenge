class CreateEligibilities < ActiveRecord::Migration
  def change
    create_table :eligibilities do |t|
      t.string :eligibility
      t.string :description

      t.timestamps null: false
    end
  end
end
