class Api::V1::Transactions::RandomController < ApplicationController

  def show
    render json: Transaction.limit(1).order("RANDOM()")
  end
end
