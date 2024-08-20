RSpec.describe TodoList do
  describe "associations" do
    it { is_expected.to have_many(:todo_items).dependent(:destroy) }
  end
end
