class Server < ApplicationRecord
    has_and_belongs_to_many :mods
end
