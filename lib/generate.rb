require 'thor'
require 'active_record'
require 'fileutils'
require 'active_support/inflector'

class Generator < Thor
  include Thor::Actions

  desc "model NAME [attributes]", "Generate a model with the given NAME and attributes"
  def model(name, *attributes)
    model_name = name.camelize
    table_name = model_name.underscore.pluralize
    attribute_pairs = attributes.map { |attr| attr.split(':') }

    # Create migration file
    timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
    migration_name = "create_#{table_name}"
    migration_file = "db/migrate/#{timestamp}_#{migration_name}.rb"
    
    create_file migration_file do
      <<-FILE
class #{migration_name.camelize} < ActiveRecord::Migration[7.0]
  def change
    create_table :#{table_name} do |t|
#{attribute_pairs.map { |name, type| "      t.#{type} :#{name}" }.join("\n")}
      t.timestamps
    end
  end
end
      FILE
    end

    say "Created migration file: #{migration_file}", :green

    # Create model file
    model_file = "app/models/#{model_name.underscore}.rb"
    create_file model_file do
      <<-FILE
class #{model_name} < ActiveRecord::Base
end
      FILE
    end

    say "Created model file: #{model_file}", :green
  end
end
