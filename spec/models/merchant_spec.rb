require 'rails_helper'

RSpec.describe Merchant, type: :model do

  it "can find a merchant with query params" do
    bb = create(:merchant, name: "Best Buy")
    apple = create(:merchant, name: "Apple")
    amazon = create(:merchant, name: "Amazon")

    expect(Merchant.find_merchant("buy")).to eq(bb)
  end
end
