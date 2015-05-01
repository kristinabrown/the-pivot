require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(fullname: "David Daniel", 
                           email: "example@sample.org",
                           role: 0,
                           phone: "222-333-4444",
                           password: "password") }
  context "is valid" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end
  end

  context "is invalid with invalid attributes" do
    it "is invalid without fullname" do
      user = User.new(email: "example@example.org", 
                      role: 0, 
                      phone: "222-333-4444",
                      password: "password")

      expect(user).to_not be_valid
    end

    it "is invalid without email" do
      user = User.new(fullname: "David Daniel", 
                      role: 0, 
                      phone: "222-333-4444",
                      password: "password")

      expect(user).to_not be_valid
    end
    
    it "it only accepts and email between 5-50 characters" do
      user = User.new(fullname: "David Daniel", 
                      email: "exam",
                      role: 0, 
                      phone: "222-333-4444",
                      password: "password")
                      
      user1 = User.new(fullname: "David Daniel", 
                      email: "example@example.orgkmalfdmlmsdlkfmalskdmflksdamlfkmads",
                      role: 0, 
                      phone: "222-333-4444",
                      password: "password")

      expect(user).to_not be_valid
      expect(user1).to_not be_valid
    end
    
    it "it is not valid with an already taken email" do
      2.times do 
        User.create(fullname: "David Daniel", 
                    email: "example@example.org", 
                    phone: "222-333-4444",
                    password: "password")
      end

      expect(User.where(email: "example@example.org").count).to eq(1)
    end
    
    it "it has a display name between 2-32 characters when provided" do
      user = User.new(fullname: "David Daniel", 
                      email: "example@example.org", 
                      phone: "222-333-4444",
                      display_name: "d",
                      password: "password")
      user1 = User.new(fullname: "David Daniel", 
                       email: "example@example.com", 
                       phone: "222-333-4444",
                       display_name: "ddddddddddddddddddddddddddddddddd",
                       password: "password")

       expect(user).to_not be_valid
       expect(user1).to_not be_valid
    end
    
    it "responds to orders" do
      expect(user.orders).to eq([])
    end
  end
end
