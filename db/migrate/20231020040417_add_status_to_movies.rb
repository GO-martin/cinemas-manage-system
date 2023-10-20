class AddStatusToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :status, :integer, default: 0
  end
end
