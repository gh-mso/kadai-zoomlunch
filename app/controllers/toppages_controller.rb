class ToppagesController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      
      @room = @category.rooms.order(created_at: :desc).all
    else
      @category = Category.first
      
      @room = Room.order(created_at: :desc).all
    end
  end
end