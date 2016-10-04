class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  def self.random 
    offset = rand(Customer.count)
    Customer.offset(offset).first
  end
end
