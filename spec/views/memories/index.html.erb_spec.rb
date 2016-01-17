require 'rails_helper'

RSpec.describe "memories/index", type: :view do
  before(:each) do
    assign(:memories, [
      Memory.create!(
        :title => "Title",
        :caption => "MyText"
      ),
      Memory.create!(
        :title => "Title",
        :caption => "MyText"
      )
    ])
  end

  it "renders a list of memories" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
