# app/models/reaction_level.rb

class ReactionLevel < ApplicationRecord
    # Asociaciones
    has_many :user_tweet_reactions
    has_many :users, through: :user_tweet_reactions
    has_many :tweets, through: :user_tweet_reactions
  
    # Validaciones
    validates :name, presence: true, uniqueness: true
    validates :emoji, presence: true, uniqueness: true
    validates :level, presence: true, uniqueness: true, 
              numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  
    # Scopes
    scope :ordered_by_level, -> { order(level: :asc) }
    
  
    # Métodos de instancia
    def display_name
      "#{emoji} #{name}"
    end
  
    # Métodos de clase
    def self.find_by_level(level)
      find_by(level: level)
    end
end