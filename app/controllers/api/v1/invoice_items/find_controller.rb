class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    @invoice_item = InvoiceItem.custom_find_by(query_params)
  end

  def index
    @invoice_items = InvoiceItem.custom_where(query_params)
  end
end
