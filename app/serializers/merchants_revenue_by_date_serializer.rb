class MerchantsRevenueByDateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_revenue
end
