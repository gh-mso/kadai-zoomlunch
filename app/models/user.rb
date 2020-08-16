class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :rooms
  has_many :room_members
  has_many :joinedrooms, through: :room_members, source: :room
  
  def join(room)
    self.room_members.find_or_create_by(room_id: room.id)
  end
  
  def leave(room)
    room_member = self.room_members.find_by(room_id: room.id)
    room_member.destroy if room_member
  end
  
  def joined?(room)
    self.joinedrooms.include?(room)
  end
  
end