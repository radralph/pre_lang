class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :msisdn
      t.string :access_token

      t.timestamps
    end
  end
end
