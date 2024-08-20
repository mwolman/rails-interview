RSpec.describe TodoItem do
  describe "associations" do
    it { is_expected.to belong_to(:todo_list) }
  end

  describe "validations" do
    it { is_expected.not_to allow_value(nil).for(:completed) }
  end
end
