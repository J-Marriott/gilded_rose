class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.quality_change
      item.limit_max_or_min_quality
      item.reduce_sell_in
    end
  end

end
