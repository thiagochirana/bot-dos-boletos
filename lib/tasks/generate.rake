# lib/tasks/generate.rake
require 'active_record'
require 'fileutils'

namespace :generate do
  desc 'Generate a model with a migration file'
  task :model, [:name, :attributes] => :environment do |t, args|
    if args[:name].nil?
      puts "Usage: rake generate:model[ModelName,field1:type,field2:type,...]"
      exit
    end

    model_name = args[:name].capitalize
    table_name = model_name.downcase.pluralize
    attributes = args[:attributes] ? args[:attributes].split(',') : []

    # Create migration file
    timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
    migration_name = "create_#{table_name}"
    migration_file = "db/migrate/#{timestamp}_#{migration_name}.rb"
    
    File.open(migration_file, 'w') do |f|
      f.puts "class #{migration_name.camelize} < ActiveRecord::Migration[6.0]"
      f.puts "  def change"
      f.puts "    create_table :#{table_name} do |t|"
      attributes.each do |attr|
        name, type = attr.split(':')
        f.puts "      t.#{type} :#{name}"
      end
      f.puts "      t.timestamps"
      f.puts "    end"
      f.puts "  end"
      f.puts "end"
    end

    puts "Created migration file: #{migration_file}"

    # Create model file
    model_file = "app/models/#{model_name.downcase}.rb"
    FileUtils.mkdir_p(File.dirname(model_file))
    File.open(model_file, 'w') do |f|
      f.puts "class #{model_name} < ActiveRecord::Base"
      f.puts "end"
    end

    puts "Created model file: #{model_file}"
  end

  task :environment do
    db_config = YAML.load_file('config/database.yml', aliases: true)
    ActiveRecord::Base.establish_connection(db_config['development'])
  end
end
