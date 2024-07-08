class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.bigint 'user_id', null: false
      t.bigint 'movie_id', null: false
      t.integer 'vote_type', null: false, default: 0
      
      t.timestamps
    end
  end
end
