class Api::V1::Merchants::RevenuesController < ApplicationController

  def show
    if revenue_params[:date]
      @revenue = Merchant.revenue_for_date(revenue_params[:merchant_id], revenue_params[:date])
    else
      @revenue = Merchant.revenue(revenue_params[:merchant_id])
    end
  end

  def revenue_params
    params.permit(:merchant_id, :date)
  end
end
