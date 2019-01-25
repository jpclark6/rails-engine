require 'rails_helper'

describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    expect(response).to be_successful

    merchants_data = JSON.parse(response.body)

    expect(merchants_data["data"].length).to eq(3)

    expect(merchants_data["data"][0]["attributes"]["name"]).to eq(Merchant.first.name)
    expect(merchants_data["data"][1]["attributes"]["name"]).to eq(Merchant.second.name)
    expect(merchants_data["data"][2]["attributes"]["name"]).to eq(Merchant.third.name)
    expect(merchants_data["data"][2]["type"]).to eq("merchant")

    expect(merchants_data["data"][0]["attributes"]["id"]).to eq(Merchant.first.id)
  end
  it "sends data on one merchant" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/#{Merchant.first.id}.json"

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body)

    expect(merchant_data["data"].length).to eq(3)

    expect(merchant_data["data"]["attributes"]["name"]).to eq(Merchant.first.name)
    expect(merchant_data["data"]["attributes"]["id"]).to eq(Merchant.first.id)
    expect(merchant_data["data"]["type"]).to eq("merchant")
  end
end