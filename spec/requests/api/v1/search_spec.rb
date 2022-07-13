require 'rails_helper'

RSpec.describe "Search Controller Actions" do

  it "can find a merchant based on partial query search" do
    bb = create(:merchant, name: "Best Buy")
    apple = create(:merchant, name: "Apple")
    amazon = create(:merchant, name: "Amazon")

    get "/api/v1/merchants/find?name=ppl"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:attributes][:name]).to eq("Apple")
  end

  it "can find all items based on partial query search" do
    bb = create(:merchant, name: "Best Buy")
    macbook = create(:item, name: "Macbook", merchant_id: bb.id)
    tv = create(:item, name: "OLED TV", merchant_id: bb.id)
    xbox = create(:item, name: "Xbox Series X", merchant_id: bb.id)
    chromebook = create(:item, name: "Chromebook", merchant_id: bb.id)

    get "/api/v1/items/find_all?name=book"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.first[:attributes][:name]).to eq("Macbook")
    expect(items.last[:attributes][:name]).to eq("Chromebook")
  end

  it "successfully returns empty array of items if no matches" do
    bb = create(:merchant, name: "Best Buy")
    macbook = create(:item, name: "Macbook", merchant_id: bb.id)
    tv = create(:item, name: "OLED TV", merchant_id: bb.id)
    xbox = create(:item, name: "Xbox Series X", merchant_id: bb.id)
    chromebook = create(:item, name: "Chromebook", merchant_id: bb.id)

    get "/api/v1/items/find_all?name=test"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items).to be_an Array
    expect(items).to be_empty
  end

  it "returns an no merchant found error if no matched merchants" do
    bb = create(:merchant, name: "Best Buy")
    apple = create(:merchant, name: "Apple")
    amazon = create(:merchant, name: "Amazon")

    get "/api/v1/merchants/find?name=TEST"

    no_merchant = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry
    expect(response).to be_successful
    expect(no_merchant[:error]).to eq("No Merchant Found")
    expect(response.status).to eq 200
  end
end
