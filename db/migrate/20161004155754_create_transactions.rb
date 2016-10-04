class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :invoice_id
      t.integer :credit_card_number
      t.integer :credit_card_expiration_date
      t.text :result

      t.timestamps
    end
  end
end
