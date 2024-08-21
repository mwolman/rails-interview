FactoryBot.define do
  factory :todo_item do
    todo_list
    name { Faker::Name.name }
    completed { Faker::Boolean.boolean }
  end
end
