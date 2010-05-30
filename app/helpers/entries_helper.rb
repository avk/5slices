require 'uri'

module EntriesHelper
  
  PREVIEW_WIDTH = 160
  PREVIEW_HEIGHT = 128
  
  FULL_WIDTH = 480
  FULL_HEIGHT = 385
  
  def preview_media(media)
    render_media(media, PREVIEW_WIDTH, PREVIEW_HEIGHT)
  end
  
  def full_media(media)
    render_media(media, FULL_WIDTH, FULL_HEIGHT)
  end
  
  def render_media(media, width, height)
    if link = video?(media) and link
      /&?v=(.*)&?/.match(link.query)
      return "<object width='#{width}' height='#{height}'><param name='movie' value='http://www.youtube.com/v/#{$1}'></param><param name='allowFullScreen' value='true'></param><param name='allowscriptaccess' value='always'></param><embed src='http://www.youtube.com/v/#{$1}' type='application/x-shockwave-flash' allowscriptaccess='always' allowfullscreen='true' width='#{width}' height='#{height}'></embed></object>"
    elsif pic?(media)
      return "<img src='#{media}' style='width:#{width}px;height:#{height};'/>"
    elsif link?(media)
      return "<p class='link_media'>#{auto_link(media)}</p>"
    else
      return "<p class='text_media'>#{media}</p>"
    end
  end
  
  def link?(media)
    # can be parsed as an HTTP link
    
    begin
      uri = URI.parse(media)
      (uri.scheme == "http") ? uri : false
    rescue URI::InvalidURIError => e
      false
    end
  end
  
  def pic?(media)
    # is a link whose path is one or more characters, followed by: 
    # "." and a valid extension (case-insensitive) at the end of the string
    
    extensions = ["jpg", "jpeg", "png", "gif"]
    ends_with_valid_extension = Regexp.new(".+\\.(" + extensions.join("|") + ")$", true)
    
    link = link?(media)
    (link and ends_with_valid_extension.match(link.path)) ? link : false
  end
  
  def video?(media)
    # is a link whose host is YouTube and path is 'watch'
    
    link = link?(media)
    is_you_tube = /^(www\.)*youtube\.com$/
    is_watchable = /^\/watch$/
    (link and is_you_tube.match(link.host) and is_watchable.match(link.path)) ? link : false
  end
  
end
