FactoryBot.define do
  factory :user do
    name { "foo bar" }
    email { "tester@example.com" }
    password { "password" }
    password_confirmation { "password" }
    activated { true }
  end
end
