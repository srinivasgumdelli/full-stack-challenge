FactoryGirl.define do
  factory :eligibility do
    sequence(:eligibility) { |i| "Test Eligibility #{i}" }
    description 'This is a generic description'
  end
end
