class MerchantsRevenueByDateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :total_revenue
end
