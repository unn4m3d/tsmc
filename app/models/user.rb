class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def login
    @login || self.username || self.email
  end

  attr_writer :login

  validate :validate_username
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

  def validate_username
    if username_changed? && self.persisted?
      errors.add(:username, "Cannot change username")
    end

    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def skin_url
    image_path("default_skin.png")
  end

  def cape_url
    ""
  end
end
