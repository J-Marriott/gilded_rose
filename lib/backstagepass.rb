class BackstagePass < Item

  def quality_change
    amount = case
      when @sell_in > 10 then 1
      when @sell_in > 5  then 2
      when @sell_in > 0  then 3
      when @sell_in <= 0 then -@quality
    end
    @quality += amount
  end

  def reduce_sell_in
    @sell_in -= 1
  end

  def limit_max_or_min_quality
    @quality = 50 if @quality > 50
    @quality = 0  if @quality < 0
  end
  
end
