class MerchantsItemsSoldSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :total_items
end
