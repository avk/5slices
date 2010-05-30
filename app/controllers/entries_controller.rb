class EntriesController < ApplicationController

  before_filter :authenticate

  def index # your entries
  end

  def show # individual entry
  end

  def create # new entry
    annotations = [{'5slices' => {'my_app' => 'finally'}}]
    
    options = {}
    options.update(:annotations => annotations.to_json)
    
    tweet = client.update(params[:status] + " #5slices", options)
    render :json => tweet.to_json
  end

end
