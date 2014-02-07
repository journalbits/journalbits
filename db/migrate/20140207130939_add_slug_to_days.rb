class AddSlugToDays < ActiveRecord::Migration
  def change
    add_column :days, :slug, :string
    add_index :days, :slug
  end
end
