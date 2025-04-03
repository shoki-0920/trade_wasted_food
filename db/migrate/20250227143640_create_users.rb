class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
docker compose exec web rails g migration AddProfileFieldsToUsers name:string avatar:string bio:text location:string