FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@example.com" }
    password 'password'
    admin false
  end

  factory :admin, class: User do
    sequence(:email) { |i| "admin#{i}@example.com" }
    password 'password'
    admin true
  end

  factory :user_feature do
    email 'srinivasgumdelli@gmail.com'
    password 'srinivasgumdelli'
    admin false
  end
end
