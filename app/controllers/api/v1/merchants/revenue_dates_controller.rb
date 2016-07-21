class Api::V1::Merchants::RevenueDatesController < ApplicationController

  def show
    @total_revenue = Merchant.revenue_for_date_all_merchants(revenue_params[:date])
  end

  def revenue_params
    params.permit(:date)
  end
end
