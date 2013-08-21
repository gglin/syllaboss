require 'spec_helper'

describe User do
  it "is valid with a full name, email, and password" do 
    user = User.new(:full_name => 'Alex Rocks', :email => 'rock@rock.com', :password => "password123")
    expect(user).to be_valid
  end

  it "is not valid without a full name" do
    user = User.new(:full_name => nil, :email => 'rock@rock.com', :password => "password123")
    expect(user).to have(1).errors_on(:full_name)
  end


  it "is not valid without an email" do
    user = User.new(:full_name => 'Alex Rocks', :email => nil, :password => "password123")
    expect(user).to have(1).errors_on(:email)
  end

  it "is not valid without a password" do
    user = User.new(:full_name => 'Alex Rocks', :email => 'rock@rock.com', :password => nil)
    expect(user).to have(1).errors_on(:password)
  end

  it "is invalid with a duplicate email address" do
    user = User.new(:full_name => 'Alex Rocks', :email => 'rock@rock.com', :password => "password123")
    user.save
    user = User.new(:full_name => 'Alex Talks', :email => 'rock@rock.com', :password => "password123")
    expect(user).to_not be_valid
  end

  it 'prints its username thru print_name'
end

