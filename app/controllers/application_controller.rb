class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = if session[:user_id]
      begin
        User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        nil
      end
    else
      nil 
    end
  end
end
