class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.custom_where(params)
    if ["name", "description", "first_name", "last_name", "status", "result"].include?(params.keys[0])
      where("LOWER(#{params.keys[0]}) LIKE ?", params.values[0].downcase)
    elsif ["unit_price"].include?(params.keys[0])
      where(unit_price: (params.values[0].to_f*100).to_i)
    else
      where(params)
    end
  end

  def self.custom_find_by(params)
    if ["name", "description", "first_name", "last_name", "status", "result"].include?(params.keys[0])
      find_by("LOWER(#{params.keys[0]}) LIKE ?", params.values[0].downcase)
    elsif ["unit_price"].include?(params.keys[0])
      find_by(unit_price: (params.values[0].to_f*100).to_i)
    else
      find_by(params)
    end
  end
end
