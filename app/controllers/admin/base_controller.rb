class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render '../../public/404' unless current_user.platform_admin?
  end
end