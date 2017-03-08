require_relative '../lib/gilded_rose'
require_relative '../lib/item'

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "sulfuras quality never degrades" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50

      items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "normal items degrade by one" do
      items = [Item.new("Chocolate", 20, 25)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 24
    end

    it "normal items degrade twice as quick after sell by date passes" do
      items = [Item.new("Chocolate", 0, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 18
    end

    it "backstage passes increase in quality by 2 when 10 days or less left" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 22
    end

    it "backstage passes increase in quality by 3 when 5 days or less left" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 23
    end

    it "backstage passes are worthless once the concert has passed" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "aged brie increases in quality as it gets older" do
      items = [Item.new("Aged Brie", 0, 48)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

  end

end
