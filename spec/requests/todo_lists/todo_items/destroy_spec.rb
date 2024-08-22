describe "DELETE /api/todolists/:todo_list_id/todoitems/:id" do
  let(:todo_list) { create(:todo_list) }
  let!(:todo_item) { create(:todo_item, todo_list:) }
  let(:request) { delete api_todo_list_todo_item_path(todo_list_id: todo_list.id, id: todo_item_id), headers: }

  context "when the todo item exists" do
    let(:todo_item_id) { todo_item.id }

    it "deletes the todo item", :aggregate_failures do
      expect { request }.to change(TodoItem, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  context "when the todo item does not exist" do
    let(:todo_item_id) { TodoItem.maximum(:id).to_i + 1 }

    it "returns a not found status", :aggregate_failures do
      request

      expect(response).to have_http_status(:not_found)
      expect(json[:error]).to eq("Todo Item not found")
    end
  end
end
