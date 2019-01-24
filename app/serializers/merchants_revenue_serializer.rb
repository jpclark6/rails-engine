class MerchantsRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
  
  attribute :total_revenue do |merchant|
    merchant.total_revenue
  end
end
