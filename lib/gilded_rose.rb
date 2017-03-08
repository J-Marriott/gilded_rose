class GildedRose
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  SELL_IN_MIN = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      quality_change(item)
      item.sell_in -= 1 unless item.name[0..7] == "Sulfuras"
    end
  end

  private

  def quality_change(item)
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      item.quality += quality_change_backstage_passes(item)
      max_or_min_quality(item)
    elsif item.name == "Aged Brie"
      item.quality += quality_change_brie(item)
      max_or_min_quality(item)
    elsif item.name[0..7] == "Conjured"
      item.quality += quality_change_conjured(item)
      max_or_min_quality(item)
    elsif item.name[0..7] == "Sulfuras"
      item.quality = item.quality
    else
      item.quality += quality_change_regular(item)
      max_or_min_quality(item)
    end
  end

  def quality_change_brie(item)
    item.sell_in > 0 ? 1 : 2
  end

  def quality_change_backstage_passes(item)
    result = case
      when item.sell_in > 10 then 1
      when item.sell_in > 5 then 2
      when item.sell_in > 0 then 3
      when item.sell_in == 0 then -item.quality
    end
    result
  end

  def quality_change_conjured(item)
    -2 if item.sell_in > 0
  end

  def quality_change_regular(item)
    item.sell_in > 0 ? -1 : -2
  end

  def max_or_min_quality(item)
    item.quality = MAX_QUALITY if item.quality > 50
    item.quality = MIN_QUALITY if item.quality < 0
  end

end
