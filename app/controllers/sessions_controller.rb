class SessionsController < ApplicationController
  def new
  end

  def create
    oauth.set_callback_url(finalize_session_url)

    session['rtoken']  = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret

    redirect_to oauth.request_token.authorize_url
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  def finalize
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])

    profile = Twitter::Base.new(oauth).verify_credentials
    session['rtoken'] = session['rsecret'] = nil
    session[:atoken] = oauth.access_token.token
    session[:asecret] = oauth.access_token.secret

    if has_annotations?
      sign_in(profile)
      redirect_back_or entries_path
    else
      redirect_to no_annotations_path
    end
  end
  
  def no_annotations
  end
end
