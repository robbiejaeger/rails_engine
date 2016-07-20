class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    @invoice_item = InvoiceItem.custom_find_by(invoice_item_params)
  end

  def index
    @invoice_items = InvoiceItem.custom_where(invoice_item_params)
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
