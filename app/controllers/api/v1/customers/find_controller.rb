class Api::V1::Customers::FindController < ApplicationController

  def index
    @customers = Customer.custom_where(customer_params)
  end

  def show
    @customer = Customer.custom_find_by(customer_params)
  end

  private

  def customer_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
