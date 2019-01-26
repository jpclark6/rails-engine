class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id

  attribute :unit_price do |ii|
    sprintf('%.2f', (ii.unit_price/100.0))
  end
end
