class ToppagesController < ApplicationController
  def index
      @rooms = Room.order(id: :desc).page(params[:page])
  end
end
