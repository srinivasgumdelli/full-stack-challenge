FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@example.com" }
    password 'password'
    factory :admin do
      admin true
    end
  end
end
