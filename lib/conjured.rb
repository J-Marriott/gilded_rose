class Conjured < Item
  
  def quality_change
    @sell_in > 0 ? @quality -= 2: @quality -= 4
  end

  def reduce_sell_in
    @sell_in -= 1
  end

  def limit_max_or_min_quality
    @quality = 50 if @quality > 50
    @quality = 0  if @quality < 0
  end

end
