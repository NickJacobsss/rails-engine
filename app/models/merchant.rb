class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items


  def self.find_merchant(query)
    where('LOWER(name) like ?', "%#{query.downcase}%")
    .order("name")
    .first
  end
end
