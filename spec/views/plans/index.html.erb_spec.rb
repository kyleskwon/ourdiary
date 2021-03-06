require 'rails_helper'

RSpec.describe "plans/index", type: :view do
  before(:each) do
    assign(:plans, [
      Plan.create!(
        :title => "Title",
        :caption => "MyText"
      ),
      Plan.create!(
        :title => "Title",
        :caption => "MyText"
      )
    ])
  end

  it "renders a list of plans" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
