class Api::V1::InvoiceItems::InvoicesController < ApplicationController

  def show
    @invoice = InvoiceItem.find(params[:invoice_item_id]).invoice
  end
end
