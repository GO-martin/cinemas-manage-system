class AddDescriptionToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :description, :text
  end
end
