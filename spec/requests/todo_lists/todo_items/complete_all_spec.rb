describe "PATCH /api/todolists/:todo_list_id/todoitems/complete_all" do
  let(:todo_list) { create(:todo_list) }
  let(:todo_items) { create_list(:todo_item, 5, todo_list:, completed: false) }
  let(:request) { patch complete_all_api_todo_list_todo_items_path(todo_list_id:) }

  context "when the todo list exists" do
    let(:todo_list_id) { todo_list.id }

    it "enqueues a job to complete all todo items", :aggregate_failures do
      expect {
        request
      }.to have_enqueued_job(CompleteAllTodoItemsJob).with(todo_list_id).on_queue("default")

      expect(response).to have_http_status(:accepted)
      expect(json["message"]).to eq("The job to complete all todo items has been enqueued.")
    end
  end

  context "when the todo list does not exist" do
    let(:todo_list_id) { -1 }

    it "returns a 404 status code with a not found message", :aggregate_failures do
      request

      expect(response).to have_http_status(:not_found)
      expect(json["error"]).to eq("Todo List not found")
    end
  end
end
