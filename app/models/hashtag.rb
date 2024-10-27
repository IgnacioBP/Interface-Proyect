class Hashtag < ApplicationRecord
    has_many :tags
    has_many :tweets, through: :tags
    
    validates :name, presence: true
end