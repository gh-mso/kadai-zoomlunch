class RoomMembersController < ApplicationController
  before_action :require_user_logged_in

  def create
    room = Room.find(params[:room_id])
    current_user.join(room)
    flash[:success] = 'successfully joined the room'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    room = Room.find(params[:room_id])
    current_user.leave(room)
    flash[:success] = 'successfully left the room'
    redirect_back(fallback_location: root_path)
  end
end
