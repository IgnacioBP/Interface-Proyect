class Tweet < ApplicationRecord
    belongs_to :user
    has_many :user_tweet_reactions
    has_many :tags
    has_many :hashtags, through: :tags
    has_many :reacting_users, through: :user_tweet_reactions, source: :user

    attribute :hashtags
    attr_accessor :current_user

    after_create :create_tags

    def set_current_user(user)
        @current_user = user
        self
    end
    

    def create_tags
        return if hashtags.blank?

        hashtags.each do |hashtag|
            tag = Hashtag.find_or_create_by(name: hashtag.strip)
            tags << Tag.create(tweet: self, hashtag: tag)
        end
    end
    
    def current_reaction_level(user)
        if user.present?
          user_tweet_reactions.find_by(user: user)&.reaction_level
        end
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
        tags.map{ |t| t.hashtag.name }.join(',')
    end
end