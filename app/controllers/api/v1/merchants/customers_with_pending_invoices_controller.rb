class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController

  def index
    @customers = Customer.joins(:invoices).where(invoices: {status: 'pending', merchant_id: params[:merchant_id]}).distinct.order(:id)
  end
end
