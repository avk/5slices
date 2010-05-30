class EntriesController < ApplicationController

  before_filter :authenticate

  def index # a user's entries
    @screen_name = (params[:screen_name]) ? params[:screen_name] : session[:screen_name]
    # @entries = client.user_timeline(:screen_name => @screen_name) # DEBUG
    
    @entries = []
    client.user_timeline(:screen_name => @screen_name).each do |tweet|
      if tweet.text =~ /\s#5slices\s/ and tweet.annotations
        tweet.annotations.each do |a| 
          @entries << a["5slices"].to_hash if a.has_key?("5slices")
        end
      end
    end
  end

  def new # start new entry
  end

  def create # post new entry
    annotations = [
      { '5slices' => params[:annotations] }
    ]
    options = { :annotations => annotations.to_json }
    
    begin
      tweet = client.update(params[:status] + " #5slices http://5slices.com/u/#{session[:screen_name]}", options)
    rescue Exception => e
      tweet = {}
    end
    render :json => tweet.to_json # DEBUG
  end
  
end
