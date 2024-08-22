describe "PATCH /api/todolists/:todo_list_id/todoitems/:id/completed" do
  let(:todo_list) { create(:todo_list) }
  let!(:todo_item) { create(:todo_item, todo_list:, completed: false) } # Ensure initial state is false
  let(:request) do
    patch completed_api_todo_list_todo_item_path(todo_list_id: todo_list.id, id: todo_item_id), headers:
  end

  context "when the todo item exists" do
    let(:todo_item_id) { todo_item.id }

    context "when the update is successful" do
      it "updates the completed field to true", :aggregate_failures do
        expect { request }.to change { TodoItem.find(todo_item.id).completed }.from(false).to(true)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the update fails" do
      it "returns an unprocessable entity status with errors", :aggregate_failures do
        allow_any_instance_of(TodoItem).to receive(:update).and_return(false)
        allow_any_instance_of(TodoItem).to receive_message_chain(:errors, :full_messages).and_return(["Update failed"])

        request

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json[:errors]).to eq(["Update failed"])
      end
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
