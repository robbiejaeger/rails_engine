class Api::V1::Items::RandomController < ApplicationController

  def show
    render json: Item.limit(1).order("RANDOM()")
  end
end
