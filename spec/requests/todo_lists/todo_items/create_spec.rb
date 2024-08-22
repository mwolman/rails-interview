describe "POST /api/todolists/:todo_list_id/todoitems" do
  let(:todo_list) { create(:todo_list) }
  let(:request) do
    post api_todo_list_todo_items_path(todo_list_id: todo_list.id), params: params.to_json, headers:
  end

  context "when the request is valid" do
    let(:params) { { todo_item: { name: "Test", completed: false } } }

    it "creates a todo item", :aggregate_failures do
      expect { request }.to change(TodoItem, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json[:name]).to eq("Test")
      expect(json[:completed]).to be(false)
    end
  end

  context "when the request is invalid" do
    let(:params) { { todo_item: { name: "Test", completed: nil } } }

    it "returns an unprocessable entity status" do
      request

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
