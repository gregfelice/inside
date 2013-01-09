require 'minitest_helper'

describe Widget do

  it "includes name in to_param" do
    widget = Widget.create!(name: "Hello World", title: "This is a test")
    widget.to_param.must_equal "#{widget.id}-hello-world"
  end

end

