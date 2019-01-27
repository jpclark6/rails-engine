require 'rails_helper'

describe "Invoice API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices.json'

    expect(response).to be_successful

    invoice_data = JSON.parse(response.body)

    expect(invoice_data["data"].length).to eq(3)

    expect(invoice_data["data"][0]["attributes"]["customer_id"]).to eq(Invoice.first.customer_id)
    expect(invoice_data["data"][1]["attributes"]["customer_id"]).to eq(Invoice.second.customer_id)
    expect(invoice_data["data"][2]["attributes"]["customer_id"]).to eq(Invoice.third.customer_id)
    expect(invoice_data["data"][2]["type"]).to eq("invoice")

    expect(invoice_data["data"][0]["attributes"]["id"]).to eq(Invoice.first.id)
    expect(invoice_data["data"][0]["attributes"]["merchant_id"]).to eq(Invoice.first.merchant_id)
    expect(invoice_data["data"][0]["attributes"]["status"]).to eq(Invoice.first.status)
    expect(invoice_data["data"][1]["attributes"]["status"]).to eq(Invoice.second.status)
  end
  it "sends data on one invoice" do
    create(:invoice)

    get "/api/v1/invoices/#{Invoice.first.id}.json"

    expect(response).to be_successful

    invoice_data = JSON.parse(response.body)

    expect(invoice_data["data"].length).to eq(3)

    expect(invoice_data["data"]["attributes"]["customer_id"]).to eq(Invoice.first.customer_id)
    expect(invoice_data["data"]["attributes"]["merchant_id"]).to eq(Invoice.first.merchant_id)
    expect(invoice_data["data"]["attributes"]["status"]).to eq(Invoice.first.status)
    expect(invoice_data["data"]["type"]).to eq("invoice")
  end
  describe 'can find invoice items from parameters' do
    before(:each) do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)

      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant_1, status: "shipped", created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-29 14:54:09 UTC')
      @invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant_2, status: "shipped", created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-29 14:54:09 UTC')
      @invoice_3 = create(:invoice, customer: @customer_2, merchant: @merchant_1, status: "shipped", created_at: '2012-03-28 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC')
      @invoice_4 = create(:invoice, customer: @customer_2, merchant: @merchant_2, status: "shipped", created_at: '2012-03-28 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC')
    end

    it 'can find by id' do
      get "/api/v1/invoices/find?id=#{@invoice_1.id}"

      expect(response).to be_successful

      invoice_data = JSON.parse(response.body)

      expect(invoice_data["data"]["id"]).to eq(@invoice_1.id.to_s)
      expect(invoice_data["data"]["type"]).to eq("invoice")
      expect(invoice_data["data"]["attributes"]["id"]).to eq(@invoice_1.id)
      expect(invoice_data["data"]["attributes"]["customer_id"]).to eq(@invoice_1.customer_id)
      expect(invoice_data["data"]["attributes"]["merchant_id"]).to eq(@invoice_1.merchant_id)
      expect(invoice_data["data"]["attributes"]["status"]).to eq(@invoice_1.status)
    end
    it 'can find by customer_id' do
      get "/api/v1/invoices/find?customer_id=#{@invoice_1.customer_id}"

      expect(response).to be_successful

      invoice_data = JSON.parse(response.body)

      expect(invoice_data["data"]["id"]).to eq(@invoice_1.id.to_s)
      expect(invoice_data["data"]["type"]).to eq("invoice")
      expect(invoice_data["data"]["attributes"]["id"]).to eq(@invoice_1.id)
      expect(invoice_data["data"]["attributes"]["customer_id"]).to eq(@invoice_1.customer_id)
      expect(invoice_data["data"]["attributes"]["merchant_id"]).to eq(@invoice_1.merchant_id)
      expect(invoice_data["data"]["attributes"]["status"]).to eq(@invoice_1.status)
    end
    it 'can find by merchant_id' do
      get "/api/v1/invoices/find?merchant_id=#{@invoice_1.merchant_id}"

      expect(response).to be_successful

      invoice_data = JSON.parse(response.body)

      expect(invoice_data["data"]["id"]).to eq(@invoice_1.id.to_s)
      expect(invoice_data["data"]["type"]).to eq("invoice")
      expect(invoice_data["data"]["attributes"]["id"]).to eq(@invoice_1.id)
      expect(invoice_data["data"]["attributes"]["customer_id"]).to eq(@invoice_1.customer_id)
      expect(invoice_data["data"]["attributes"]["merchant_id"]).to eq(@invoice_1.merchant_id)
      expect(invoice_data["data"]["attributes"]["status"]).to eq(@invoice_1.status)
    end
    it 'can find by status' do
      get "/api/v1/invoices/find?status=#{@invoice_1.status}"

      expect(response).to be_successful

      invoice_data = JSON.parse(response.body)

      expect(invoice_data["data"]["id"]).to eq(@invoice_1.id.to_s)
      expect(invoice_data["data"]["type"]).to eq("invoice")
      expect(invoice_data["data"]["attributes"]["id"]).to eq(@invoice_1.id)
      expect(invoice_data["data"]["attributes"]["customer_id"]).to eq(@invoice_1.customer_id)
      expect(invoice_data["data"]["attributes"]["merchant_id"]).to eq(@invoice_1.merchant_id)
      expect(invoice_data["data"]["attributes"]["status"]).to eq(@invoice_1.status)
    end
    it 'can find by created_at' do
      get "/api/v1/invoices/find?created_at=#{@invoice_1.created_at}"

      expect(response).to be_successful

      invoice_data = JSON.parse(response.body)

      expect(invoice_data["data"]["id"]).to eq(@invoice_1.id.to_s)
      expect(invoice_data["data"]["type"]).to eq("invoice")
      expect(invoice_data["data"]["attributes"]["id"]).to eq(@invoice_1.id)
      expect(invoice_data["data"]["attributes"]["customer_id"]).to eq(@invoice_1.customer_id)
      expect(invoice_data["data"]["attributes"]["merchant_id"]).to eq(@invoice_1.merchant_id)
      expect(invoice_data["data"]["attributes"]["status"]).to eq(@invoice_1.status)
    end
    it 'can find by updated_at' do
      get "/api/v1/invoices/find?updated_at=#{@invoice_1.updated_at}"

      expect(response).to be_successful

      invoice_data = JSON.parse(response.body)

      expect(invoice_data["data"]["id"]).to eq(@invoice_1.id.to_s)
      expect(invoice_data["data"]["type"]).to eq("invoice")
      expect(invoice_data["data"]["attributes"]["id"]).to eq(@invoice_1.id)
      expect(invoice_data["data"]["attributes"]["customer_id"]).to eq(@invoice_1.customer_id)
      expect(invoice_data["data"]["attributes"]["merchant_id"]).to eq(@invoice_1.merchant_id)
      expect(invoice_data["data"]["attributes"]["status"]).to eq(@invoice_1.status)
    end
  end

end