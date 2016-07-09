class ResourceSiteEligibilities < ActiveRecord::Migration
  def up
    create_table :resource_site_eligibilities do |t|
      t.belongs_to :resource_site, index: true
      t.belongs_to :eligibility, index: true
    end
  end
end
