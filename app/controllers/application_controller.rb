class ApplicationController < ActionController::API
  include ActionController::Serialization

  def fix_unit_price(whitelist)
    if whitelist["unit_price"]
      whitelist["unit_price"] = whitelist["unit_price"].gsub('.', '')
    end
    return whitelist
  end
end
