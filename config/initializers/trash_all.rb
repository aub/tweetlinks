def trash_all!

  if Rails.env.production?
    # puts "ARE YOU JOKING?"
    # return
  end

  ActiveRecord::Base.connection.tables.each do |t|
    unless %w(schema_migrations).include?(t)
      puts "truncating #{t}"
      ActiveRecord::Base.connection.execute("TRUNCATE #{t}")
    end
  end

  Rails.cache.clear

  APP_REDIS.flushdb
end
