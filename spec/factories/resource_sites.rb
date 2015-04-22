FactoryGirl.define do
  factory :resource_site do
    sequence(:name) { |i| "Resource Site Site #{i}" }
    description 'This is a generic description.'
    address '222 Broadway, New York, NY, 10038'
  end
end
