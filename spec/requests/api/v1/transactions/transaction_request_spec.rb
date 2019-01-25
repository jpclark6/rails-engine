require 'rails_helper'

describe "Transaction API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions.json'

    expect(response).to be_successful

    transactions_data = JSON.parse(response.body)

    expect(transactions_data["data"].length).to eq(3)

    expect(transactions_data["data"][0]["attributes"]["invoice_id"]).to eq(Transaction.first.invoice_id)
    expect(transactions_data["data"][1]["attributes"]["invoice_id"]).to eq(Transaction.second.invoice_id)
    expect(transactions_data["data"][2]["attributes"]["invoice_id"]).to eq(Transaction.third.invoice_id)
    expect(transactions_data["data"][2]["type"]).to eq("transaction")

    expect(transactions_data["data"][0]["attributes"]["id"]).to eq(Transaction.first.id)
    expect(transactions_data["data"][0]["attributes"]["credit_card_number"]).to eq(Transaction.first.credit_card_number)
    expect(transactions_data["data"][0]["attributes"]["result"]).to eq(Transaction.first.result)
  end
  it "sends data on one transaction" do
    create_list(:transaction, 3)

    get "/api/v1/transactions/#{Transaction.first.id}.json"

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body)

    expect(merchant_data["data"].length).to eq(3)

    expect(merchant_data["data"]["attributes"]["id"]).to eq(Transaction.first.id)
    expect(merchant_data["data"]["attributes"]["invoice_id"]).to eq(Transaction.first.invoice_id)
    expect(merchant_data["data"]["attributes"]["credit_card_number"]).to eq(Transaction.first.credit_card_number)
    expect(merchant_data["data"]["attributes"]["result"]).to eq(Transaction.first.result)
    expect(merchant_data["data"]["type"]).to eq("transaction")
  end
end