module Api
  module TodoLists
    class TodoItemsController < Api::ApiController
      # POST /api/todolists/:todo_list_id/todoitems
      def create
        @todo_item = todo_list.todo_items.new(todo_item_params)

        if @todo_item.save
          render json: @todo_item, status: :created
        else
          render json: @todo_item.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/todolists/:todo_list_id/todoitems/:id
      def destroy
        @todo_item = todo_list.todo_items.find(params[:id])
        @todo_item.destroy
        head :no_content
      end

      # PATCH /api/todolists/:todo_list_id/todoitems/:id/completed
      def completed
        @todo_item = todo_list.todo_items.find(params[:id])

        if @todo_item.update(completed: true)
          render json: @todo_item, status: :ok
        else
          render json: { errors: @todo_item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def todo_item_params
        params.require(:todo_item).permit(:name, :completed)
      end

      def todo_list
        @todo_list ||= TodoList.find(params[:todo_list_id])
      end
    end
  end
end
