class InvoiceItemSearch
  attr_reader :id,
              :quantity

  def initialize(params)
    @id       = params["id"].to_i if params["id"]
    @quantity = params["quantity"].to_i if params["quantity"]
  end

  def find
    if id
      InvoiceItem.find(id)
    else
      InvoiceItem.where(quantity: quantity)
    end
  end
end
