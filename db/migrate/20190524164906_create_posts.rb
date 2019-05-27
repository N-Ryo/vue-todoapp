class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :firstContent, null: false
      t.text :secondContent
      t.text :thirdContent
      t.text :forthContent
      t.text :fifthContent
      t.string :rname

      t.timestamps
    end
  end
end
