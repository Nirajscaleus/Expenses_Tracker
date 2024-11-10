class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.string :title
      t.integer :date
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
