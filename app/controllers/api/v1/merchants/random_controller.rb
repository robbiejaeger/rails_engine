class Api::V1::Merchants::RandomController < ApplicationController

  def show
    render json: Merchant.limit(1).order("RANDOM()")
  end
end
