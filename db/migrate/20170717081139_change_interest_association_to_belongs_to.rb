class ChangeInterestAssociationToBelongsTo < ActiveRecord::Migration[5.1]
  def change
    drop_table :user_interests
    add_reference :interests, :user, foreign_key: true
  end
end
