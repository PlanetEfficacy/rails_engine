class InvoiceSearch
  attr_reader :id,
              :status
  
  def initialize(params)
    @id     = params["id"].to_i if params["id"]
    @status = params["status"]
  end

  def find
    if id
      Invoice.find(id)
    else
      Invoice.where(status: status)
    end
  end
end
