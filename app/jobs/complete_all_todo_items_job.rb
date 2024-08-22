class CompleteAllTodoItemsJob < ApplicationJob
  queue_as :default

  BATCH_SIZE = ENV.fetch("TODO_ITEMS_BATCH_SIZE", 1000).to_i

  def perform(todo_list_id)
    todo_list = TodoList.find(todo_list_id)

    todo_list.todo_items.in_batches(of: BATCH_SIZE).each_with_index do |batch, index|
      batch.update_all(completed: true)
    rescue StandardError => e
      Rails.logger.error("Failed to update TodoItems in batch ##{index + 1}: #{e.message}")
    end
  end
end
