class AddEligibilityToResourceSite < ActiveRecord::Migration
  def change
    add_column :resource_sites, :eligibility_id, :integer
    add_foreign_key :resource_sites, :eligibilities
  end
end
