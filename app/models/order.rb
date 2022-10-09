class Order < ApplicationRecord
  enum status: { pending: 0, waiting_confirmation: 3, canceled: 5, on_route: 7, delivered: 10 }
  validates :takeout_address, :weight, :heigth, :width, :depth, :delivery_address, :name,
  :email, :customer_id, :total_distance, :status, presence: true
  before_validation :generate_code
  has_one :order_start
  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
