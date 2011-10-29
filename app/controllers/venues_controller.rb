class VenuesController < ApplicationController
  before_filter :logged_in?

  def search
    @q = CGI.escapeHTML(params[:q])
    v = current_user.foursquare.venues(:q => CGI.escape(params[:q]),
                                       :geolat => params[:lat],
                                       :geolong => params[:long])
    if v.blank?
      @venues = []
    else
      @venues = v.andand["groups"].andand[0].andand["venues"] || []
    end
  end

  def new
  end

  def create
    redirect_to(new_venue_path) and return unless request.post?
    h = params[:venue] || {}

    @venue = current_user.foursquare.addvenue h
    unless @venue.nil?
      current_user.foursquare.checkin(:vid => @venue["id"])
      flash[:notice] = "You added and checked in to #{@venue["name"]}."
      redirect_to(history_path) and return
    else
      flash[:error] = "Could not add #{params[:venue][:name]}"
      redirect_to(new_venue_path) and return
    end
  end

end
