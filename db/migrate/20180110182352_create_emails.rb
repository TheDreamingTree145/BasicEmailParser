class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.string :receiver
      t.string :sender
      t.string :subject
      t.string :cc
      t.date :sent
      t.text :content

      t.timestamps
    end
  end
end
