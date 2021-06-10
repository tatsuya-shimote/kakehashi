class User < ApplicationRecord
  mount_uploader :image, ProfileimageUploader
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format:{with:VALID_EMAIL_REGEX},
            uniqueness: true
  validates :content, length: {maximum: 200}
  has_secure_password
  
  has_many :groups
  has_many :members
  has_many :posts
  has_many :group ,through: :members, source: :group
  attr_accessor :remember_token
  
  #渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    #Userのremember_token属性をここで定義。
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def join(will_join_group)
    unless self.members.find_by(group_id: will_join_group)
      self.members.find_or_create_by(group_id: will_join_group.id)
    end
  end
  
  def exit(join_group)
    grp = self.members.find_by(group_id: join_group.id)
    grp.destroy if grp
  end
  
 
end
