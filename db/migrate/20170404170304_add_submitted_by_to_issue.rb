class AddSubmittedByToIssue < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :submitted_by, :string
  end
end
