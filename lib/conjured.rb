class Conjured < Item
  def quality_change
    @sell_in > 0 ? @quality -= 2: @quality -= 4
  end
end
