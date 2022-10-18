class Order < ApplicationRecord
  enum status: { pending: 0, waiting_confirmation: 3, canceled: 5, on_route: 7, delivered: 10 }
  validates :takeout_address, :weight, :heigth, :width, :depth, :delivery_address, :name,
  :email, :customer_id, :total_distance, :status, presence: true
  validates :weight, :heigth, :width, :depth, comparison: { greater_than: 0 }
  validates :code, uniqueness: true
  validates :code, length: { is: 15 }
  validates :customer_id, length: { is: 14 }
  validates :customer_id, format: { with: /\d{14}/}

  before_validation :generate_code, on: :create
  has_one :order_start
  has_one :order_end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
