class Permissions
  attr_reader :user, 
              :controller, 
              :action, 
              :store_slug
  
  def initialze(user)
    @user = user || User.new
  end
  
  def allow?(controller, action, store_slug = nil)
    @controller = controller
    @action = action
    @store_slug = store_slug
    
    case 
    when user.platform_admin?
      platform_admin_permissions
    else
      registered_user_permissions
    end
  end
  
  private
  
  def platform_admin_permissions
    return true if controller == "users"
    return true if controller == "orders"
    return true if controller == "sessions"
    return true if controller == "stores"
    return true if controller == "stores::items"
  end
  
  def store_admin_permissions
    return true if controller == "users"
    return true if controller == "orders"
    return true if controller == "sessions"
    return true if controller == "stores" && action.in?(%w(index))
    return true if controller == "stores" && action.in?(%w(edit update)) && id.in?(["#{@user.store_slug}"]
    return true if controller == "stores::items" && action.in?(%w(index show))
    return true if controller == "stores::items" && action.in?(%w(index)) && id.in?(%w(edit update))
  end
  
  def registered_user_permissions
    return true if controller == "sessions"
    return true if controller == "stores" && action.in?(%w(index))
    return true if controller == "stores::items" && action.in?(%w(index show))
  end
end