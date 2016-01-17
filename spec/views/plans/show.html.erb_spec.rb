require 'rails_helper'

RSpec.describe "plans/show", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :title => "Title",
      :caption => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
