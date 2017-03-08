class GildedRose
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  SELL_IN_MIN = 0
  SPECIAL = ['Backstage passes', 'Aged Brie', 'Conjured'].freeze
  LEGENDARY = ['Sulfuras'].freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if LEGENDARY.any? { |i| item.name.include? i }
      quality_change_backstage(item) if item.name[0..15] == 'Backstage passes'
      quality_change_brie(item)      if item.name == 'Aged Brie'
      quality_change_conjured(item)  if item.name[0..7] == 'Conjured'
      quality_change(item) unless SPECIAL.any? { |i| item.name.include? i }
      max_or_min_quality(item)
      reduce_sell_in(item)
    end
  end

  private

  def reduce_sell_in(item)
    item.sell_in -= 1 unless item.name[0..7] == 'Sulfuras'
  end

  def quality_change_brie(item)
    item.sell_in > 0 ? item.quality += 1 : item.quality += 2
  end

  def quality_change_backstage(item)
    amount = case
     when item.sell_in > 10 then 1
     when item.sell_in > 5 then 2
     when item.sell_in > 0 then 3
     when item.sell_in == 0 then -item.quality
    end
    item.quality += amount
  end

  def quality_change_conjured(item)
    item.quality -= 2 if item.sell_in > 0
  end

  def quality_change(item)
    item.sell_in > 0 ? item.quality -= 1 : item.quality -= 2
  end

  def max_or_min_quality(item)
    item.quality = MAX_QUALITY if item.quality > 50
    item.quality = MIN_QUALITY if item.quality < 0
  end

end
