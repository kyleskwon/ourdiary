require 'rails_helper'

RSpec.describe "memories/edit", type: :view do
  before(:each) do
    @memory = assign(:memory, Memory.create!(
      :title => "MyString",
      :caption => "MyText"
    ))
  end

  it "renders the edit memory form" do
    render

    assert_select "form[action=?][method=?]", memory_path(@memory), "post" do

      assert_select "input#memory_title[name=?]", "memory[title]"

      assert_select "textarea#memory_caption[name=?]", "memory[caption]"
    end
  end
end
