require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(fullname: "David Daniel", 
                           email: "example@sample.org",
                           phone: "222-333-4444",
                           password: "password",
                           street: "123 First Ave",
                           city: "Denver",
                           state: "CO",
                           zipcode: "80211",
                           credit_card: "4242424242424242",
                           cc_expiration_date: "2015-11-01"
                           ) }

  context "is valid" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is valid with a credit card with dashes" do
      user = User.create(fullname: "David Daniel", 
                           email: "example@sample.org",
                           phone: "222-333-4444",
                           password: "password",
                           street: "123 First Ave",
                           city: "Denver",
                           state: "CO",
                           zipcode: "80211",
                           credit_card: "4242-4242-4242-4242",
                           cc_expiration_date: "2015-11-01"
                           )
      expect(user).to be_valid
    end

    it "is valid with a credit card with spaces" do
      user = User.create(fullname: "David Daniel", 
                           email: "example@sample.org",
                           phone: "222-333-4444",
                           password: "password",
                           street: "123 First Ave",
                           city: "Denver",
                           state: "CO",
                           zipcode: "80211",
                           credit_card: "4242 4242 4242 4242",
                           cc_expiration_date: "2015-11-01"
                           )
      expect(user).to be_valid
    end
  end

  context "is invalid with invalid attributes" do
    it "is invalid without fullname" do
      user = User.new(fullname: nil, 
                       email: "example@sample.org",
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: "CO",
                       zipcode: "80211",
                       credit_card: "4242424242424242",
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).not_to be_valid
    end

    it "is invalid without email" do
      user = User.new(fullname: "David Smith", 
                       email: nil,
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: "CO",
                       zipcode: "80211",
                       credit_card: "4242424242424242",
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).to_not be_valid
    end
    
    it "is invalid with improperly formatted email" do
      user = User.new(fullname: "David Smith", 
                       email: "david",
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: "CO",
                       zipcode: "80211",
                       credit_card: "4242424242424242",
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).not_to be_valid
    end

    it "is invalid without a street address" do
      user = User.new(fullname: "David Smith", 
                       email: "david@example.com",
                       phone: "222-333-4444",
                       password: "password",
                       street: nil,
                       city: "Denver",
                       state: "CO",
                       zipcode: "80211",
                       credit_card: "4242424242424242",
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).to_not be_valid
    end

    it "is invalid without a city address" do
      user = User.new(fullname: "David Smith", 
                       email: "david@example.com",
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: nil,
                       state: "CO",
                       zipcode: "80211",
                       credit_card: "4242424242424242",
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).to_not be_valid
    end
    
    it "is invalid without a state" do
      user = User.new(fullname: "David Smith", 
                       email: "david@example.com",
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: nil,
                       zipcode: "80211",
                       credit_card: "4242424242424242",
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).to_not be_valid
    end

    it "is invalid without a zipcode" do
      user = User.new(fullname: "David Smith", 
                       email: "david@example.com",
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: "CO",
                       zipcode: nil,
                       credit_card: "4242424242424242",
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).to_not be_valid
    end

    it "is invalid with an invalid zipcode format" do
      user = User.new(fullname: "David Smith", 
                       email: "david@example.com",
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: "CO",
                       zipcode: "11111111",
                       credit_card: "4242424242424242",
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).not_to be_valid
    end

    it "is invalid without a credit card" do
      user = User.new(fullname: "David Smith", 
                       email: "david@example.com",
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: "CO",
                       zipcode: "11111",
                       credit_card: nil,
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).not_to be_valid
    end

    it "is invalid with a credit card not 15 or 16 digits long" do
      user = User.new(fullname: "David Smith", 
                       email: "david@example.com",
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: "CO",
                       zipcode: "11111",
                       credit_card: "4242",
                       cc_expiration_date: "2015-11-01"
                       ) 

      expect(user).not_to be_valid
    end

    it "is invalid without a cc expiration date" do
      user = User.new(fullname: "David Smith", 
                       email: "david@example.com",
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: "CO",
                       zipcode: "11111",
                       credit_card: "4242424242424242",
                       cc_expiration_date: nil
                       ) 

      expect(user).not_to be_valid
    end


    it "it only accepts and email between 5-50 characters" do
      user = User.new(fullname: "David Daniel", 
                      email: "exam",
                      phone: "222-333-4444",
                      password: "password")
                      
      user1 = User.new(fullname: "David Daniel", 
                      email: "example@example.orgkmalfdmlmsdlkfmalskdmflksdamlfkmads",
                      phone: "222-333-4444",
                      password: "password")

      expect(user).to_not be_valid
      expect(user1).to_not be_valid
    end
    
    it "it is not valid with an already taken email" do
      2.times do 
        User.create(fullname: "David Daniel", 
                   email: "david@sample.org",
                   phone: "222-333-4444",
                   password: "password",
                   street: "123 First Ave",
                   city: "Denver",
                   state: "CO",
                   zipcode: "80211",
                   credit_card: "4242424242424242",
                   cc_expiration_date: "2015-11-01"
                   )
      end
      expect(User.where(email: "david@sample.org").count).to eq(1)
    end
    
    it "it has a display name between 2-32 characters when provided" do
      user = User.new(fullname: "David Daniel", 
                     email: "example@sample.org",
                     display_name: "d",
                     phone: "222-333-4444",
                     password: "password",
                     street: "123 First Ave",
                     city: "Denver",
                     state: "CO",
                     zipcode: "80211",
                     credit_card: "4242424242424242",
                     cc_expiration_date: "2015-11-01"
                     )
      expect(user).not_to be_valid

      user1 = User.new(fullname: "David Daniel", 
                   email: "david@sample.org",
                   display_name: "ddddddddddddddddddddddddddddddddd",
                   phone: "222-333-4444",
                   password: "password",
                   street: "123 First Ave",
                   city: "Denver",
                   state: "CO",
                   zipcode: "80211",
                   credit_card: "4242424242424242",
                   cc_expiration_date: "2015-11-01"
                   )

       expect(user1).not_to be_valid
    end

  end
end
