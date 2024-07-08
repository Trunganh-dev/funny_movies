class AddUniqueIndexToVotes < ActiveRecord::Migration[6.1]
  def change
    add_index :votes, [:movie_id, :user_id], unique: true
  end
end
