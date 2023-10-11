class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :director, null: false
      t.text :description
      t.string :lead_actor
      t.string :lead_actress
      t.date :release_date
      t.string :language
      t.string :genres, array: true, default: []

      t.timestamps
    end
  end
end
