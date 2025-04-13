class AddFishingSpotRefToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :fishing_spot, null: false, foreign_key: true
  end
end
