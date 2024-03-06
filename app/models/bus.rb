class Bus < ApplicationRecord
  #  serialize :seats, type: Array, coder: JSON
  has_many :reservations, dependent: :destroy
  validates :name, :registration_no, :route, :number_of_seats, presence: true
 
  def list_of_available_seats
    (1..number_of_seats).to_a - reservations.pluck(:seats).flatten.uniq
  end

  def self.search(query)
    where("name LIKE ? OR route LIKE ?", "%#{query}%", "%#{query}%")
  end
end
