class CreateOrder
#initialize with the params from form
#parse the params,
#assign user id to user id
#assign status
#assign total

  #find all beer objects by ID and push them into orders_beers
  def initialize(params)
    @params = params
  end

  def user_id
    @params["order_info"]["user_id"] 
  end
    
  def total
    @params["order_info"]["total"] 
  end

  def beers
    @params["order_info"]["beers"].map do |beer_id|
      Beer.find(beer_id.to_i)
    end 
  end

end