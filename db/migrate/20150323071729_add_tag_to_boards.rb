class AddTagToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :tag, :string
  end
end
