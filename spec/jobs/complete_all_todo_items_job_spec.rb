RSpec.describe CompleteAllTodoItemsJob do
  include ActiveJob::TestHelper

  let(:todo_list) { create(:todo_list) }
  let!(:todo_items) { create_list(:todo_item, 5, todo_list:, completed: false) }
  let(:job) { described_class.perform_later(todo_list.id) }

  it "updates all todo items to completed" do
    perform_enqueued_jobs { job }

    expect(todo_items.all? { |item| item.reload.completed? }).to be true
  end

  it "logs an error if the update_all query fails", :aggregate_failures do
    batch_index = 1
    allow(Rails.logger).to receive(:error)

    # Simulate an error in the update_all method
    allow_any_instance_of(ActiveRecord::Relation).to receive(:update_all)
      .and_raise(StandardError, "Simulated batch update error")

    perform_enqueued_jobs { job }

    expect(Rails.logger).to have_received(:error) do |message|
      expect(message).to include("Failed to update TodoItems in batch ##{batch_index}: Simulated batch update error")
    end
  end
end
