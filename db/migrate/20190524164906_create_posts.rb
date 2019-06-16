class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :firstContent
      t.text :secondContent
      t.text :thirdContent
      t.text :forthContent
      t.text :fifthContent
      t.string :rname
      t.boolean :is_display, default: true
      t.integer :status

      t.timestamps
    end
  end
end
