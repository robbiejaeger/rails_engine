class Api::V1::Transactions::RandomController < ApplicationController
  respond_to :json, :xml

  def show
    respond_with Transaction.limit(1).order("RANDOM()")
  end
end
