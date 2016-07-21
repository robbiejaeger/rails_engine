class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController

  def index
    @customers = Customer.with_pending_invoices(merchant_params[:merchant_id])
  end

  private

  def merchant_params
    params.permit(:merchant_id)
  end
end
