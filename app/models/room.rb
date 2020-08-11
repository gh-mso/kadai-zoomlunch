class Room < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :room_members
  has_many :memberusers, through: :room_members, source: :user
end
