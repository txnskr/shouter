class AddProfileImageAndColorElementsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :profile_bg, :string
  	add_column :users, :profile_fg, :string
  	add_column :users, :profile_image, :string
  end
end
