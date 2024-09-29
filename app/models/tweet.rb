class Tweet < ApplicationRecord
    belongs_to :user
    has_many :user_tweet_reactions
    has_many :tags
    has_many :hashtags, through: :tags
    has_many :reacting_users, through: :user_tweet_reactions, source: :user

    attribute :hashtags

    after_create :create_tags

    def create_tags
        return if hashtags.blank?

        hashtags.each do |hashtag|
            tag = Hashtag.find_or_create_by(name: hashtag.strip)
            tags << Tag.create(tweet: self, hashtag: tag)
        end
    end
    

    def creation_date
        created_at.strftime("%e %b %Y")
    end

    def list_hashtags
        tags.map{ |t| t.hashtag.name }.join(',')
    end
end