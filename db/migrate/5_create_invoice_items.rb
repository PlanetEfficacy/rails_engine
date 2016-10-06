class CreateInvoiceItems < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :invoice_items do |t|
      t.references :item, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: true
      t.integer :quantity
      t.integer :unit_price

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
