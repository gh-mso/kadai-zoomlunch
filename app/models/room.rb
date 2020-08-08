class Room < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :room_menbers
  has_many :users, through: :room_menbers, source: :user
end
