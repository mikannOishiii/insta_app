class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.string :email
      t.string :website
      t.text :pr_text
      t.string :phone
      t.string :gender

      t.timestamps
    end
  end
end
