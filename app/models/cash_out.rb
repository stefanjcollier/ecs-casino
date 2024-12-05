class CashOut < ApplicationRecord
  validates :name, presence: true
  validates :cash, presence: true
  validates :shifts, presence: true
  validates :tickets, presence: true

  def winner?
    position.present?
  end
end
