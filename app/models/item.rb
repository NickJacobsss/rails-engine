class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_items(query)
    where('LOWER(name) like ?', "%#{query.downcase}%")
  end
end
