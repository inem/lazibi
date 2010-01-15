class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do
      fkey    :user
      fkey    :auction
      integer :bid_type
      timestamps!

  def self.down
    drop_table :orders