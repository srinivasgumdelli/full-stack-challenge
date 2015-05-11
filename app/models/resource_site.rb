class ResourceSite < ActiveRecord::Base
  has_one :eligibility, :class_name => 'Eligibility', :foreign_key => 'eligibility_id'
  validates :name, presence: true, uniqueness: true
  validates :description, :address, :eligibility_id, presence: true
end
