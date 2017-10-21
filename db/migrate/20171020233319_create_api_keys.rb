class CreateApiKeys < ActiveRecord::Migration[5.1]
  
  def change
    
    create_table :api_keys do |t|
      t.string :email, null: false, uniqueness: true
      t.string :api_key, null: false, index: true
      t.integer :num_requests, null: false, default: 0
      
      t.timestamps
    end
  end
end