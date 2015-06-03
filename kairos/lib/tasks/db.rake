namespace :db do

  desc "Dumps the database to db/backup/"
  task :dump => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      export_to = ENV['EXPORT_BACKUP_FILENAME'] || "#{app}.#{Time.now.strftime('%d-%m-%Y')}.dump"
      cmd = "pg_dump --host #{host} --username #{user} --verbose --clean --no-owner --no-acl --format=c #{db} > #{Rails.root}/db/backup/#{export_to}"
    end
    puts cmd
    exec cmd
  end

  desc "Restores the database dump from db/backup/"
  task :restore => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      import_from = ENV['IMPORT_BACKUP_FILENAME'] || "#{app}.last.dump"
      cmd = "pg_restore --verbose --host #{host} --username #{user} --clean --no-owner --no-acl --dbname #{db} #{Rails.root}/db/backup/#{import_from}"
    end
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end

  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
        ActiveRecord::Base.connection_config[:host],
        ActiveRecord::Base.connection_config[:database],
        ActiveRecord::Base.connection_config[:username]
  end

end