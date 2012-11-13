class CreateShouts < ActiveRecord::Migration
  def change
    create_table :shouts do |t|
      t.text :message
      t.timestamps :created_at
    end
  end
end
