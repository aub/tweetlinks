class Api::V1::TweetsController < ApplicationController

  before_filter :require_login

  def index
    tweets = current_user.tweets.with_cloudinary_id
    render json: { tweets: tweets }, status: 200
  end

  private

  def require_login
    if !current_user
      render nothing: true, status: 401
    end
  end
end
