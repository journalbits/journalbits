class PusherController < ApplicationController
  protect_from_forgery except: [:auth]

  def auth
    if current_user && current_user.id == params[:channel_name].split("-")[-1]
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render json: response
    else
      render text: "Forbidden", status: '403'
    end
  end
end