class Order < ApplicationRecord
  enum status: { pending: 0, canceled: 5, delivered: 10 }
  validates :takeout_address, :weight, :heigth, :width, :depth, :delivery_address, :name,
  :email, :customer_id, :total_distance, :status, presence: true
  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
