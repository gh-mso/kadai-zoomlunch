class Room < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  belongs_to :category
  belongs_to :user
  has_many :room_members, dependent: :destroy
  has_many :memberusers, through: :room_members, source: :user
end
