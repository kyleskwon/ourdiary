require 'rails_helper'

RSpec.describe "memories/show", type: :view do
  before(:each) do
    @memory = assign(:memory, Memory.create!(
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
