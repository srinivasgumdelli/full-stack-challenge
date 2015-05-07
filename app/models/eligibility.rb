class Eligibility < ActiveRecord::Base
  validates :eligibility, presence: true, uniqueness: true
  validates :description, presence: true
  before_destroy :no_referenced_resource_sites
  belongs_to :resource_site

  private
  def no_referenced_resource_sites
    resource_sites = ResourceSite.where(:eligibility_id => id)
    return if resource_sites.nil?
    false
  end
end
