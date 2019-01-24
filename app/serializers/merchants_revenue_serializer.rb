class MerchantsRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :revenue

  attribute :revenue do |merchant|
    sprintf('%.2f', (merchant.revenue/100.0))
  end
end
