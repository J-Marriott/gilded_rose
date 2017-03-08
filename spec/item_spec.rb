require_relative '../lib/gilded_rose'
require_relative '../lib/item'

describe Item do

  describe "#to_s" do
    it "converts item to string" do
      item = Item.new("foo", 0, 0)
      expect(item.to_s).to eq "foo, 0, 0"
    end
  end

end
