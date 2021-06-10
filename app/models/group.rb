class Group < ApplicationRecord
  validates :learning, presence: true
  validates :limit, presence: true
  validates :content, presence: true, length: {maximum: 200}
  belongs_to :user
  has_many :members
  has_many :posts ,dependent: :destroy
  has_many :member, through: :members, source: :user
end
