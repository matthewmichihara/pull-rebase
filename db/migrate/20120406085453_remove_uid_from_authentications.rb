class RemoveUidFromAuthentications < ActiveRecord::Migration
  def up
    remove_column :authentications, :uid
      end

  def down
    add_column :authentications, :uid, :string
  end
end
