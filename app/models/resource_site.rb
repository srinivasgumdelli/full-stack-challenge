class ResourceSite < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :description, :address, presence: true
  has_many :eligibilities
end
