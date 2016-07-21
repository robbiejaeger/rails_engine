class Api::V1::Invoices::FindController < ApplicationController

  def show
    @invoice = Invoice.custom_find_by(query_params)
  end

  def index
    @invoices = Invoice.custom_where(query_params)
  end
end
