class CustomerSearch
  attr_reader :id,
              :first_name,
              :last_name
              

  def initialize(params)
    @id         = params["id"].to_i if params["id"]
    @first_name = params["first_name"].to_i if params["first_name"]
    @last_name  = params["last_name"].to_i if params["last_name"]
  end

  def find
    if id
      Customer.find(id)
    elsif first_name
      Customer.find_by(first_name: first_name)
    else
      Customer.find_by(last_name: last_name)
    end
  end
  
  def find_all
    if id
      Customer.find(id)
    elsif first_name
      Customer.where(first_name: first_name)
    else
      Customer.where(last_name: last_name)
    end
  end
end