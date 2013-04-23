module ReportsHelper

  def cc(value)
    if value >= 90
      "green"
    elsif value < 90 && value >= 50
      "orange"
    elsif value < 50
      "red"
    end
  end

end
