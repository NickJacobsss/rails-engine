require 'rails_helper'

RSpec.describe "Merchant Items Request" do

  it "sends all items that belong to a merchant" do
    merchant1 = create(:merchant)
    items = create_list(:item, 5, merchant_id: merchant1.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(5)

    result[:data].each do |item|
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

end
