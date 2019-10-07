class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :ident
      t.string :tracking_code
      t.float :weight
      t.float :length
      t.float :height
      t.float :width
      t.string :product
      t.integer :no_of_products
      t.string :origin
      t.string :destination
      t.datetime :etd
      t.datetime :eta
      t.string :service_level
      t.float :quotation
      t.string :status
      t.float :cbm
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
