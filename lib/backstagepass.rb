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
end
