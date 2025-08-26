class CreateSolidCacheEntries < ActiveRecord::Migration[8.0] 
  def change
    create_table :solid_cache_entries, id: :bigint do |t|
      t.binary :key, null: false, limit: 1024
      t.binary :value, null: false
      t.datetime :created_at, null: false, precision: 6
      
      t.index :key, unique: true
    end
  end
end
