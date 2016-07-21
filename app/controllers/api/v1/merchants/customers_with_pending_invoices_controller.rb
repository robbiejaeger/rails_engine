class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController

  def index
    @customers = Customer.with_pending_invoices(params[:merchant_id])
  end
end
