class Standard < Item
  def quality_change
    @sell_in > 0 ? @quality -= 1 : @quality -= 2
  end
end
