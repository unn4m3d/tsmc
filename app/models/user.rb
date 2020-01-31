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

  has_attached_file :skin
  has_attached_file :cape
  validates_attachment(
    :skin,
    content_type: { content_type: 'image/png' },
    dimensions: Settings.skin_dimensions,
    size: { less_than: 250.kilobytes }
  )
  validates_attachment(
    :cape,
    content_type: { content_type: 'image/png' },
    dimensions: Settings.cape_dimensions,
    size: { less_than: 250.kilobytes }
  )

  has_attached_file :avatar
  validates_attachment(
    :avatar,
    content_type: { content_type: ['image/png', 'image/gif', 'image/jpeg']},
    size: {less_than: 750.kilobytes }
  )

  def validate_username
    if username_changed? && persisted?
      errors.add(:username, 'Cannot change username')
    end

    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  def skin_url
    if skin
      skin.url
    else
      Rails.root.join('public').join('default_skin.png')
    end
  end

  def cape_url
    if cape
      cape.url
    else
      ''
    end
  end

  def avatar_url
    if avatar
      avatar.url
    else
      nil
    end
  end

  has_many :posts

  def roles
    @roles ||= role.to_s.split(';')
  end

  def is?(role)
    roles.include? role.to_s
  end
end
