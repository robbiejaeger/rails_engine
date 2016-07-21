class Api::V1::Customers::FindController < ApplicationController

  def index
    @customers = Customer.custom_where(query_params)
  end

  def show
    @customer = Customer.custom_find_by(query_params)
  end
end
