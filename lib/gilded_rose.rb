class GildedRose
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.quality_change
      limit_max_or_min_quality(item)
      reduce_sell_in(item)
    end
  end

  private

  def reduce_sell_in(item)
    item.sell_in -= 1 unless item.is_a? Sulfura
  end

  def limit_max_or_min_quality(item)
    item.quality = MAX_QUALITY if item.quality > 50 unless item.is_a? Sulfura
    item.quality = MIN_QUALITY if item.quality < 0
  end

end
