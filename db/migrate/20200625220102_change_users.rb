class ChangeUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :role 
      t.boolean :admin
    end 
  end
end
