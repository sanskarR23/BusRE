class Bus < ApplicationRecord
    belongs_to :user
    has_many :reservations

  def self.search(query)
    where("name LIKE ? OR route LIKE ?", "%#{query}%", "%#{query}%")
  end
end

