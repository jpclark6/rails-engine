class MerchantsRevenueByDateSerializer
  include FastJsonapi::ObjectSerializer
  attribute :total_revenue do |object|
    sprintf('%.2f', object.total_revenue / 100)
  end
end
