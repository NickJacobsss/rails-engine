require 'rails_helper'

RSpec.describe Item, type: :model do

  it "can find all matching items with query params" do
    bb = create(:merchant, name: "best buy")
    
    macbook = create(:item, name: "Macbook", merchant_id: bb.id)
    tv = create(:item, name: "OLED TV", merchant_id: bb.id)
    xbox = create(:item, name: "Xbox Series X", merchant_id: bb.id)
    chromebook = create(:item, name: "Chromebook", merchant_id: bb.id)

    expect(Item.find_items("book")).to eq([macbook, chromebook])
  end
end
