require_relative '../lib/gilded_rose'
require_relative '../lib/item'
require_relative '../lib/aged'
require_relative '../lib/backstagepass'
require_relative '../lib/conjured'
require_relative '../lib/standard'
require_relative '../lib/sulfura'

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Standard.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "sulfuras quality never degrades" do
      items = [Sulfura.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
      expect(items[0].sell_in).to eq 0
    end

    it "normal items degrade by one" do
      items = [Standard.new("Chocolate", 20, 25)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 24
    end

    it "normal items degrade twice as quick after sell by date passes" do
      items = [Standard.new("Chocolate", 0, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 18
      expect(items[0].sell_in).to eq(-1)
    end

    it "backstage passes increase in quality by 1 when more than 10 days left" do
      items = [BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 11, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 21
    end

    it "backstage passes increase in quality by 2 when 10 days or less left" do
      items = [BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 22
    end

    it "backstage passes increase in quality by 3 when 5 days or less left" do
      items = [BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 23
    end

    it "backstage passes quality drops to 0 once the concert has passed" do
      items = [BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "aged brie increases in quality as it gets older" do
      items = [Aged.new("Aged Brie", 0, 48)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq(-1)
    end

    it "the quality of an item is never more than 50" do
      items = [Aged.new("Aged Brie", 5, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq 4
    end

    it "the quality of an item is never negative" do
      items = [Standard.new("Chocolate", 1, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "conjured items decrease in quality twice as quick as regular items" do
      items = [Conjured.new("Conjured", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 18
    end

  end

end
