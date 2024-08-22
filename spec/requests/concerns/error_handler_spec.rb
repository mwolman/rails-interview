describe "ErrorHandler" do
  before do
    Rails.application.routes.draw do
      get "test_error_handler/:id", to: "test#error_action"
    end

    stub_const("TestController", Class.new(Api::ApiController) do
      def error_action
        TodoItem.find(params[:id])
      end
    end)
  end

  after { Rails.application.reload_routes! }

  describe "render_not_found" do
    it "returns a 404 with the correct error message", :aggregate_failures do
      get "/test_error_handler/1"

      expect(response).to have_http_status(:not_found)
      expect(json["error"]).to eq("Todo Item not found")
    end
  end
end
