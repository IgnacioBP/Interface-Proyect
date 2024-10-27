class UserTweetReaction < ApplicationRecord
    belongs_to :user
    belongs_to :tweet
    belongs_to :reaction_level
    validates :user_id, uniqueness: { scope: :tweet_id }
end