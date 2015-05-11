FactoryGirl.define do
  factory :resource_site do
    sequence(:name) { |i| "ResourceSite#{i}" }
    description 'This is a generic description.'
    address '222 Broadway, New York, NY, 10038'
    after(:build) do |resource_site|
      resource_site.eligibility_id = FactoryGirl.create(:eligibility).id
    end
  end
end