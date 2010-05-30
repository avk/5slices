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
    annotations = [{'5slices' => {'my_app' => 'finally'}}]
    # annotations = [
    #   {
    #     '5slices' => {
    #       'Morrison' => 'No eternal reward will forgive us now for wasting the dawn. - Jim Morrison',
    #       'overload' => 'http://slipstre.am/',
    #       'Chirp' => 'http://farm5.static.flickr.com/4046/4522190635_8e233783c1.jpg',
    #       'summer' => 'toes deep in Croatan (Virginia Beach, VA)',
    #       'Lost' => 'http://www.youtube.com/watch?v=G-DShnvNNv0'
    #     }
    #   }
    # ]
    
    options = {}
    options.update(:annotations => annotations.to_json)
    
    begin
      tweet = client.update(params[:status] + " #5slices http://5slices.com/u/#{session[:screen_name]}", options)
    rescue Exception => e
      tweet = {}
    end
    render :json => tweet.to_json
  end
  
end
