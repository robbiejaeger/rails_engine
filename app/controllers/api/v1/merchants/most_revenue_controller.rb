class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    # byebug
    @merchants = Merchant.most_revenue(most_revenue_params[:quantity])
    # byebug
  end

  def most_revenue_params
    params.permit(:quantity)
  end
end
