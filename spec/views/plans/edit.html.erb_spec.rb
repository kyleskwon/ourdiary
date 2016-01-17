require 'rails_helper'

RSpec.describe "plans/edit", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :title => "MyString",
      :caption => "MyText"
    ))
  end

  it "renders the edit plan form" do
    render

    assert_select "form[action=?][method=?]", plan_path(@plan), "post" do

      assert_select "input#plan_title[name=?]", "plan[title]"

      assert_select "textarea#plan_caption[name=?]", "plan[caption]"
    end
  end
end
