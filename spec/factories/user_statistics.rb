FactoryBot.define do
  factory :user_statistic do
    user { nil }
    platform { "MyString" }
    followers { 1 }
    posts { 1 }
    likes { 1 }
    comments { 1 }
  end
end
