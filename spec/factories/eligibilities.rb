FactoryGirl.define do
  factory :eligibility do
    sequence(:eligibility) { |i| "Eligibility#{i}" }
    description 'This is a generic description'
  end
end
