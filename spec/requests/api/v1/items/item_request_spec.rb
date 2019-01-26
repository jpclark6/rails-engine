require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items.json'

    expect(response).to be_successful

    items_data = JSON.parse(response.body)

    expect(items_data["data"].length).to eq(3)

    expect(items_data["data"][0]["attributes"]["name"]).to eq(Item.first.name)
    expect(items_data["data"][1]["attributes"]["name"]).to eq(Item.second.name)
    expect(items_data["data"][2]["attributes"]["name"]).to eq(Item.third.name)
    expect(items_data["data"][2]["type"]).to eq("item")

    expect(items_data["data"][0]["attributes"]["id"]).to eq(Item.first.id)
    expect(items_data["data"][0]["attributes"]["name"]).to eq(Item.first.name)
    expect(items_data["data"][0]["attributes"]["description"]).to eq(Item.first.description)
    unit_price = sprintf('%.2f', (Item.first.unit_price/100.0))
    expect(items_data["data"][0]["attributes"]["unit_price"]).to eq(unit_price)
    expect(items_data["data"][0]["attributes"]["merchant_id"]).to eq(Item.first.merchant_id)
  end
  it "sends data on one item" do
    create_list(:item, 3)

    get "/api/v1/items/#{Item.first.id}.json"

    expect(response).to be_successful

    item_data = JSON.parse(response.body)

    expect(item_data["data"].length).to eq(3)

    expect(item_data["data"]["attributes"]["name"]).to eq(Item.first.name)
    expect(item_data["data"]["attributes"]["description"]).to eq(Item.first.description)
    unit_price = sprintf('%.2f', (Item.first.unit_price/100.0))
    expect(item_data["data"]["attributes"]["unit_price"]).to eq(unit_price)
    expect(item_data["data"]["attributes"]["merchant_id"]).to eq(Item.first.merchant_id)
    expect(item_data["data"]["type"]).to eq("item")
  end
end