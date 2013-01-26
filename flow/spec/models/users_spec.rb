require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe "Users Model" do 
  
  it "throws an error when I can't find a user by email" , :focus => true do
    expect { User.find(0) }.to raise_error(ActiveRecord::RecordNotFound)
    expect { Employee.find(0) }.to raise_error(ActiveRecord::RecordNotFound)
    expect { User.find_by_email!("skdfjahskjdhf") }.to raise_error(ActiveRecord::RecordNotFound)
  end

end
