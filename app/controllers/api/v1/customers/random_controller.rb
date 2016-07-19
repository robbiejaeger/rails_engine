class Api::V1::Customers::RandomController < ApplicationController

  def show
    render json: Customer.limit(1).order("RANDOM()")
  end
end
