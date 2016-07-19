class Api::V1::Customers::RandomController < ApplicationController

  def show
    @customer = Customer.limit(1).order("RANDOM()")
  end
end
