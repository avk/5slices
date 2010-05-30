class EntriesController < ApplicationController

  before_filter :authenticate

  def index # your entries
  end

  def show # individual entry
    @entry = Entry.find(params[:id])
    words = @entry.words.split(" ")
    
    # map words => associated media
    @slices = {}
    (1..5).each do |count|
      @slices[words[count - 1]] = @entry.send(("media#{count}").to_sym)
    end
  end

  def create # new entry
    annotations = [{'5slices' => {'my_app' => 'finally'}}]
    
    options = {}
    options.update(:annotations => annotations.to_json)
    
    begin
      # @entry = Entry.new(:author => session[:screen_name])
      # @entry.words = params[:status]
      # (1..5).each do |count|
      #   @entry.send("media#{count}=".to_sym, params["media#{count}".to_sym])
      # end
      tweet = client.update(params[:status] + " #5slices", options)
    rescue Exception => e
      tweet = {}
    end
    render :json => tweet.to_json
  end

end
