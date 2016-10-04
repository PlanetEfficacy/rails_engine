class ItemSearch
  attr_reader :id,
              :name

  def initialize(params)
    @id       = params["id"].to_i if params["id"]
    @name     = params["name"] if params["name"]
  end

  def find
    if id
      Item.find(id)
    else
      Item.find_by(name: name)
    end
  end
end
