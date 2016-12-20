# User model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def login
    @login || username || email
  end

  attr_writer :login

  validate :validate_username
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  validates :username, presence: true, uniqueness: {
    case_sensitive: false
  }

  def validate_username
    if username_changed? && persisted?
      errors.add(:username, 'Cannot change username')
    end

    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  def skin_url
    Rails.root.join('public').join('default_skin.png')
  end

  def cape_url
    ''
  end

  has_many :posts

  def roles
    @roles ||= role.to_s.split(';')
  end

  def is?(role)
    roles.include? role.to_s
  end
end
