json.extract! shipment, :id, :ident, :tracking_code, :weight, :length, :height, :width, :product, :etd, :eta, :service_level, :quotation, :status, :cbm, :user_id, :created_at, :updated_at
json.url shipment_url(shipment, format: :json)
