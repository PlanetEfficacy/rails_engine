class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :invoices do |t|
      t.references :customer, index: true, foreign_key: true
      t.references :merchant, index: true, foreign_key: true
      t.citext :status

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
