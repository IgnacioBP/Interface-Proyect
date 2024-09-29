class CreateUserTweetReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tweet_reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true
      t.references :reaction_level, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_tweet_reactions, [:user_id, :tweet_id], unique: true
  end
end