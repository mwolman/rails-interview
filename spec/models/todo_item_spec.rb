describe TodoItem do
  describe "factory" do
    it "has a valid factory" do
      todo_item = build(:todo_item)
      expect(todo_item).to be_valid
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:todo_list) }
  end

  describe "validations" do
    it { is_expected.not_to allow_value(nil).for(:completed) }
  end
end
