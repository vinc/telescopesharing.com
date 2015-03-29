module TelescopesHelper
  def number_to_distance(number)
    units = { mili: "mm", unit: "m" }
    number_to_human(number, units: units, precision: 2)
  end
end
