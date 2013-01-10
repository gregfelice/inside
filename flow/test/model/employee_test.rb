require 'minitest_helper'

describe Employee do

  it "has a name that is not nil"

  it "has a job title that is not nil"

  it "has employees" do

    employee = Employee.create!(full_name: "Hello World", job_title: "This is a test")
    
    1.must_equal 2

  end


  

end
