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
end