class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :amount, default: 0
      t.integer :payment_status, default: 0
      t.integer :order_status, default: 0
      t.datetime :payment_date
      t.datetime :delivery_date
      t.belongs_to :user, foreign_key: true, null: false
    end
  end
end
