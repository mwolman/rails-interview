FactoryBot.define do
  factory :todo_list do
    name { Faker::Name.name }
  end
end
