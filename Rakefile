require 'active_record'
require 'yaml'
require 'rake'
require 'fileutils'
require_relative 'lib/generate'

namespace :db do
  desc 'Create the database'
  task :create => :environment do
    db_config = YAML.load_file('config/database.yml', aliases: true)
    config = db_config['development']

    case config['adapter']
    when 'sqlite3'
      dir = File.dirname(config['database'])
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      ActiveRecord::Base.establish_connection(config)
      ActiveRecord::Base.connection
    when 'mysql2', 'postgresql'
      ActiveRecord::Base.establish_connection(config.merge('database' => nil))
      ActiveRecord::Base.connection.create_database(config['database'], config)
    else
      raise "Unknown adapter: #{config['adapter']}"
    end
  end

  desc 'Migrate the database'
  task :migrate => :environment do
    db_config = YAML.load_file('config/database.yml', aliases: true)
    ActiveRecord::Base.establish_connection(db_config['development'])
    migration_context = ActiveRecord::MigrationContext.new('db/migrate', ActiveRecord::SchemaMigration)
    migration_context.migrate
  end

  task :environment do
    db_config = YAML.load_file('config/database.yml', aliases: true)
    ActiveRecord::Base.establish_connection(db_config['development'])
  end
end

desc 'Generate files'
task :generate do
  ARGV.shift # Remove 'generate' from ARGV
  Generator.start(ARGV)
end
