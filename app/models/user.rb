class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true
  validates :password, length: { in: 10..16 }
end
