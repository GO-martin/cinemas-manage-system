class AddNameToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :name, :string
  end
end
