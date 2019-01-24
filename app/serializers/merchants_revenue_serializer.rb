class MerchantsRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :total_revenue

  attribute :total_revenue do |merchant|
    sprintf('%.2f', (merchant.total_revenue/100.0))
  end
end
