class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :completed, inclusion: [true, false]
end
