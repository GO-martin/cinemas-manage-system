class DeleteAttributesToMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :lead_actor
    remove_column :movies, :lead_actress
    remove_column :movies, :language
    remove_column :movies, :genres
  end
end
