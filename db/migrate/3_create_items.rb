class CreateItems < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :items do |t|
      t.citext :name
      t.citext :description
      t.integer :unit_price
      t.references :merchant, index: true, foreign_key: true

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
