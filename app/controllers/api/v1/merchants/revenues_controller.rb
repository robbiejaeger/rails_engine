class Api::V1::Merchants::RevenuesController < ApplicationController

  def show
    if params[:date]
      @revenue = Merchant.revenue_for_date(params[:merchant_id], params[:date])
    else
      @revenue = Merchant.revenue(params[:merchant_id])
    end
  end
end
