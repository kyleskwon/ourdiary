require 'rails_helper'

RSpec.describe "memories/new", type: :view do
  before(:each) do
    assign(:memory, Memory.new(
      :title => "MyString",
      :caption => "MyText"
    ))
  end

  it "renders new memory form" do
    render

    assert_select "form[action=?][method=?]", memories_path, "post" do

      assert_select "input#memory_title[name=?]", "memory[title]"

      assert_select "textarea#memory_caption[name=?]", "memory[caption]"
    end
  end
end
