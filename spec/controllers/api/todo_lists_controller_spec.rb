require 'rails_helper'

describe Api::TodoListsController do
  render_views

  describe 'GET index' do
    let!(:todo_list) { TodoList.create(name: 'Setup RoR project') }

    context 'when format is HTML' do
      it 'raises a routing error' do
        expect {
          get :index
        }.to raise_error(ActionController::RoutingError, 'Not supported format')
      end
    end

    context 'when format is JSON' do
      it 'returns a success code' do
        get :index, format: :json

        expect(response).to have_http_status(:ok)
      end

      it 'includes todo list records' do
        get :index, format: :json

        todo_lists = response.parsed_body

        aggregate_failures 'includes the id and name' do
          expect(todo_lists.count).to eq(1)
          expect(todo_lists[0].keys).to contain_exactly('id', 'name')
          expect(todo_lists[0]['id']).to eq(todo_list.id)
          expect(todo_lists[0]['name']).to eq(todo_list.name)
        end
      end
    end
  end
end
