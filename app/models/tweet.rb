# app/models/tweet.rb
class Tweet < ApplicationRecord
    belongs_to :user
    has_many :user_tweet_reactions, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :tags, dependent: :destroy
    has_many :hashtags, through: :tags
    has_many :reacting_users, through: :user_tweet_reactions, source: :user
  
    attr_accessor :hashtags # Permite asignar hashtags desde el controlador
  
    after_create :create_tags # Crea los tags después de crear el tweet
  
  
    def create_tags
      return if hashtags.blank?

      hashtags.split(',').map(&:strip).each do |hashtag_name|
        hashtag = Hashtag.find_or_create_by(name: hashtag_name)
        tag = tags.create(hashtag: hashtag)
        puts "Created Tag: #{tag.inspect} with Hashtag: #{hashtag.inspect}" # Verifica la creación
      end
    end

  
    def current_reaction_level(user)
      user_tweet_reactions.find_by(user: user)&.reaction_level if user.present?
    end
  
    def react(reaction_level, user)
      user_reaction = UserTweetReaction.find_or_initialize_by(user: user, tweet: self)
      user_reaction.reaction_level = reaction_level
      user_reaction.save
    end
  
    def creation_date
      created_at.strftime("%e %b %Y")
    end
  
    def list_hashtags
      tags.map { |t| t.hashtag.name }.join(', ')
    end
  end
  