class AddUniqueIndexToMoviesVideoId < ActiveRecord::Migration[6.1]
  def change
    add_index :movies, :video_id, unique: true
  end
end