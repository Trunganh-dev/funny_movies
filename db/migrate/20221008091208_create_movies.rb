class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.bigint 'user_id', null: false
      t.string 'title', null: false
      t.text 'description'
      t.string 'thumb_url', null: false
      t.string 'video_id', null: false
      t.bigint 'vote_downs_count', null: false, default: 0
      t.bigint 'vote_ups_count', null: false, default: 0
      
      t.timestamps
    end
  end
end
