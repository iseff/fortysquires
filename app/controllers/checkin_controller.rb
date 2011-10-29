class CheckinController < ApplicationController
  before_filter :logged_in?

  def index
  end


  def nearby_venues
    @venues = current_user.foursquare.venues(:geolat => params[:lat],
                                             :geolong => params[:long],
                                             :limit => 10)
    render :layout => false
  end

  def perform
    @checkin = current_user.foursquare.checkin(:vid => params[:vid])
    @venue = current_user.foursquare.venue(:vid => params[:vid])
    flash[:notice] = "You're now at #{@venue["name"]}"
    redirect_to history_path
  end
end
