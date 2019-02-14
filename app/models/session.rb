class Session < ApplicationRecord
  belongs_to :user, optional: true
end
