class Api::V1::InvoiceItems::RandomController < ApplicationController

  def show
    @invoice_item = InvoiceItem.limit(1).order("RANDOM()")[0]
  end
end
