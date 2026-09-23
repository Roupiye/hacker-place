class AddIntrinsicsUriToLgoProcesses < ActiveRecord::Migration[8.1]
  def change
    add_column :lgo_processes, :intrinsics_uri, :string
  end
end
