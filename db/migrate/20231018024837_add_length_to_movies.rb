class AddLengthToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :length, :integer
  end
end
