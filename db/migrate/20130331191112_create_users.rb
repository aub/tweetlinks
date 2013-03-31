class CreateUsers < ActiveRecord::Migration
  def up
    create_table 'users', :force => true do |t|
      t.string :auth_token
      t.string :auth_secret
      t.timestamps
    end
  end

  def down
    drop_table 'users'
  end
end
