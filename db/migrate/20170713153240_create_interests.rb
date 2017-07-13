class CreateInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :interests do |t|
      t.string :name
    end

    create_table :user_interests do |t|
      t.belongs_to :user, index: true
      t.belongs_to :interest, index: true
    end
  end
end
