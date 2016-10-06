class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :invoice_id, :item_id, :quantity, :unit_price
  def unit_price
    "#{'%.2f' % (object.unit_price/100.0)}"
  end
end
