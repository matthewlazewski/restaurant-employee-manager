class Jobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t| 
      t.string :name 
    end 
  end
end
