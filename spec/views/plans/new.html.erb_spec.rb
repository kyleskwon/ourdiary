require 'rails_helper'

RSpec.describe "plans/new", type: :view do
  before(:each) do
    assign(:plan, Plan.new(
      :title => "MyString",
      :caption => "MyText"
    ))
  end

  it "renders new plan form" do
    render

    assert_select "form[action=?][method=?]", plans_path, "post" do

      assert_select "input#plan_title[name=?]", "plan[title]"

      assert_select "textarea#plan_caption[name=?]", "plan[caption]"
    end
  end
end
