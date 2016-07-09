class ResourceSiteEligibility < ActiveRecord::Base
  belongs_to :resource_site
  belongs_to :eligibility
  # accepts_nested_attributes_for :eligibilities
end

# ResourceSite.first.resource_site_eligibilities.create({:resource_site_id=> 1, :eligibility_id=>5})
