class Post < ApplicationRecord
  after_create_commit { PostBroadcastJob.perform_later self }
  validates :message, presence: true, length: {maximum: 200}
  belongs_to :user
  belongs_to :group
end
