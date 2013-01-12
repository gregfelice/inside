require "test_helper"

describe "Widget integration" do

  it "shows widget's name" do
    name = "Test #{Time.now}"
    widget = Widget.create!(name: name, title: "This is a test")
    visit widget_path(widget)
    page.text.must_include name
  end

end


