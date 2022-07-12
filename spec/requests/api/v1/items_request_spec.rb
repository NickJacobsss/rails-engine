require 'rails_helper'

RSpec.describe "Items API" do

  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 5, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    # binding.pry

    expect(items[:data].count).to eq(5)

      items[:data].each do |item|
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it "can get one item by ID" do
      merchant = create(:merchant)
      id = create(:item, merchant_id: merchant.id).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(response).to be_successful

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end

    it "returns 404 if item doesnt exist" do
        get "/api/v1/items/123456"
        expect(response.message).to eq("Not Found")
        expect(response.status).to eq 404
    end

    it "can create/post an item" do
      merchant = create(:merchant)
      item_params = ({
        name: 'Xbox',
        description: 'Plays games in 4k',
        unit_price: 500.00,
        merchant_id: merchant.id
        })

      post "/api/v1/items", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(item_params)

      item = Item.last

      expect(response).to be_successful
      expect(item.name).to eq("Xbox")
      expect(item.description).to eq("Plays games in 4k")
      expect(item.unit_price).to eq(500.00)
      expect(item.merchant_id).to eq(merchant.id)

    end

    it "fails to create item without all attributes" do
      merchant = create(:merchant)
      item_params = ({
        name: 'Xbox',
        description: 'Plays games in 4k',
        })

      post "/api/v1/items", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(item_params)

      expect(response.status).to eq 404

    end

    it "can delete items" do
      merchant = create(:merchant)
      item_id = create(:item, merchant_id: merchant.id).id
      delete "/api/v1/items/#{item_id}"

      expect(response.status).to eq 204
    end

    it "can update an item" do
      merchant = create(:merchant)
      item_id = create(:item, merchant_id: merchant.id).id
      new_params = {
        name: 'Xbox',
        description: 'Plays games in 4k',
        unit_price: 500.00,
        merchant_id: merchant.id
      }

      patch "/api/v1/items/#{item_id}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_params)

      updated_item = Item.find_by(id: item_id)

      expect(response).to be_successful
      expect(updated_item.name).to eq("Xbox")
      expect(updated_item.description).to eq("Plays games in 4k")
      expect(updated_item.unit_price).to eq(500.00)
      expect(updated_item.merchant_id).to eq(merchant.id)
    end


    it "updates item even with missing information" do
      merchant = create(:merchant)
      item_id = create(:item, merchant_id: merchant.id).id
      item_params = ({
        name: 'Xbox',
        description: 'Plays games in 4k',
        })

      patch "/api/v1/items/#{item_id}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(item_params)

      updated_item = Item.find_by(id: item_id)

      expect(updated_item.name).to eq("Xbox")
      expect(updated_item.description).to eq("Plays games in 4k")
    end

    it "will fail update if ID is a string" do
      merchant = create(:merchant)
      item_id = create(:item, merchant_id: merchant.id).id
      item_params = ({
        name: 'Xbox',
        description: 'Plays games in 4k',
        merchant_id: "12345"
        })

      patch "/api/v1/items/#{item_id}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(item_params)

      expect(response.status).to eq 404
    end

    it "can show the merchant for an item" do
      merchant = create(:merchant)
      item_id = create(:item, merchant_id: merchant.id).id

      get "/api/v1/items/#{item_id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end


  end
