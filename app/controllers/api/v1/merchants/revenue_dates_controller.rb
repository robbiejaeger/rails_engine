class Api::V1::Merchants::RevenueDatesController < ApplicationController

  def show
    @total_revenue = Merchant.revenue_for_date_all_merchants(params[:date])
  end
end
