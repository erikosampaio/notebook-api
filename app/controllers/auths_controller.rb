class AuthsController < ApplicationController

  def create
    hmac_secret = 'my$ecretK3y'
    payload = { name: params[:name], exp: Time.now.to_i + 30 }
    token = JWT.encode payload, hmac_secret, 'HS256'
    render json: { name: params[:name], token: token, expires: payload[:exp] }
  end
end
