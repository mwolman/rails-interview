describe TodoList do
  describe "factory" do
    it "has a valid factory" do
      todo_list = build(:todo_list)
      expect(todo_list).to be_valid
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:todo_items).dependent(:destroy) }
  end
end
