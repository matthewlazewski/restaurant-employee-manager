class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username 
      t.string :email 
      t.string :password_digest
      t.integer :job_id
    end 
  end
end
