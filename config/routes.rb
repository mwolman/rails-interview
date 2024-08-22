Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: %i[index], path: :todolists do
      resources :todo_items, only: %i[create destroy], path: :todoitems, module: "todo_lists" do
        patch :completed, on: :member
      end
    end
  end

  resources :todo_lists, only: %i[index new], path: :todolists
end
