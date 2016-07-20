class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.case_insensitive_where(params)
    if ["name", "description", "first_name", "last_name", "status", "result"].include?(params.keys[0])
      where("LOWER(#{params.keys[0]}) LIKE ?", params.values[0].downcase)
    else
      where(params)
    end
  end

  def self.case_insensitive_find_by(params)
    if ["name", "description", "first_name", "last_name", "status", "result"].include?(params.keys[0])
      find_by("LOWER(#{params.keys[0]}) LIKE ?", params.values[0].downcase)
    else
      find_by(params)
    end
  end
end
