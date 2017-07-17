class AddHobbyTypeToInterests < ActiveRecord::Migration[5.1]
  def change
    add_column :interests, :interest_type, :integer
  end
end
