class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    @items = Invoice.find(params[:invoice_id]).items
  end
end
