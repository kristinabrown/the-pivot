require "rails_helper"

RSpec.describe "registered user can bid" type: :feature do 

  def create_user
    user = User.create(fullname: "Sam Spade", 
                       email: "sam@sample.com",
                       role: 0,
                       phone: "222-333-4444",
                       password: "password",
                       street: "123 First Ave",
                       city: "Denver",
                       state: "CO",
                       zipcode: "80211",
                       credit_card: "4242424242424242",
                       cc_expiration_date: "11/2015"
                      )
  end

  def user_logs_in
    visit login_path
    fill_in("user[email]",    with: "sam@example.com" )
    fill_in("user[password]", with: "password" )  
    click_button "Login"
  end
  
  it "can see items to bid on" do 
    user_logs_in

  end
end