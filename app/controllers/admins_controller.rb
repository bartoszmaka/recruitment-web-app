class AdminsController < ApplicationController
  def index
    authorize! :manage, User
    @users = User.all
    my_sql_magic = <<-SQL
      SELECT COUNT(*)
      FROM interests
      INNER JOIN users
        ON users.id = interests.user_id
      WHERE
        name LIKE 'cosm%' AND
        --  0 stands for 'health'
        interest_type = 0 AND
        -- 1 stands for 'female'
        users.gender = 1 AND
        users.age BETWEEN 20 AND 30
    SQL
    @my_number = ActiveRecord::Base.connection.execute(my_sql_magic).to_a.first.values.first
  end
end
