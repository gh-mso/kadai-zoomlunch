class RoomsController < ApplicationController
  before_action :require_user_logged_in, only: [:create]
  before_action :correct_user, only: [:destroy]
  
  def show
    @room = Room.find(params[:id])
  end
  
  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    @room.update(room_params)
    redirect_to :action => 'show'
  end
  
  def new
    @room = Room.new
    @category = Category.first
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:success] = 'room was successfully created'
      redirect_to root_url
    else
      flash.now[:danger] = 'failed to create room'
      render 'rooms/new'
    end
  end

  def destroy
    @room.destroy
    flash[:success] = 'room was deleted'
    redirect_to root_url
  end
  
  private
  
  def room_params
    params.require(:room).permit(:name, :description, :date_and_time, :url, :category_id)
  end

  def correct_user
    @room = current_user.rooms.find_by(id: params[:id])
    unless @room
      redirect_to root_url
    end
  end
end
