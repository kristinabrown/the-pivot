class CreateOrder
  def initialize(params)
    @params = params
  end

  def user_id
    @params["order_info"]["user_id"] 
  end
    
  def total
    @params["order_info"]["total"] 
  end
  
  def quantities(order)
    beers.each do |beer|
      ob = order.order_beers.find_by(beer_id: beer.id)
      ob.update(quantity: @params["order_info"]["beers"]["#{beer.id}"]["quantity"])
    end
  end

  def beers
    @params["order_info"]["beers"].keys.map do |beer_id|
      Beer.find(beer_id.to_i)
    end 
  end
end
