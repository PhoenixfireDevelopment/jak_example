class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
