class DropUsersJobs < ActiveRecord::Migration
  def change
    drop_table :user_jobs
  end
end
