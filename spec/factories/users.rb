FactoryBot.define do
  factory :user do
    name { "foo" }
    email { "tester@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
