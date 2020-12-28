# frozen_string_literal: true
# This migration comes from jak (originally 20191023170840)

class CreateJakPowers < ActiveRecord::Migration[5.2]
  def change
    create_table :jak_powers do |t|
      t.references :user, index: true
      t.references :role, index: true

      t.timestamps
    end
  end
end
