class AddToggleToWishlist < ActiveRecord::Migration[5.2]
  def change
    add_column :wishlists, :added, :boolean, default: false
  end
end
