class EnablePostgresExtensions < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
    enable_extension 'citext'
    enable_extension 'unaccent'
  end
end
