class SessionsController < ApplicationController
  include Auth

  def me
    if current_user
      user = {
        name:  current_user.name,
        email: current_user.email,
        image: current_user.image
      }
    end

    render json: user
  end

  def create
    user = Authorization::User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id

    redirect_to request.env['omniauth.params']['redirect_url'] || '/'
  end

  def destroy
    session[:user_id] = nil
    reset_session

    redirect_to params.fetch('redirect_url')
  end
end
