FactoryBot.define do
  factory :user do
    last_name             {"test"}
    first_name            {"test"}
    kana_last_name        {"test"}
    kana_first_name       {"test"}
    nickname              {"test"}
    email                 {"test@gmail.com"}
    password              {"111111"}
    password_confirmation {"111111"}
  end
end