class Item < ApplicationRecord
  belongs_to :merchant

  def self.random
    offset = rand(Item.count)
    Item.offset(offset).first
  end
end
