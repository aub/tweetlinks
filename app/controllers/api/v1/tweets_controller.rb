class Api::V1::TweetsController < ApplicationController

  before_filter :require_login

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20

    tweets = current_user.
      tweets.
      recent_first.
      most_recent(6.hours).
      with_cloudinary_id.
      paginate(page: page, per_page: per_page).
      map do |t|
        t.with_data_view(:full)
      end

    render json: { tweets: tweets }, status: 200
  end

  private

  def require_login
    if !current_user
      render nothing: true, status: 401
    end
  end
end
