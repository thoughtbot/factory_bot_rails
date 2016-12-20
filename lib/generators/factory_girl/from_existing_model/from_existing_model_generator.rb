module FactoryGirl
  module Generators
    class FromExistingModelGenerator < Rails::Generators::Base
      argument :classes, :type => :array, default: [], :banner => "ClassName ClassName"
      class_option :all, :type => :boolean, :default => false, :desc => "Generate factories for all models in model-dir"
      class_option :model_dir, :type => :string, :default => "app/models", :desc => "The directory where the models live"

      desc "Description:
    Create factories for all (specified) active_record models based on their schema definition.
    Uses the model generator under the hood, so look at rails generate factory_girl:model for more options. "

      def create_fixture_files
        sanity_check
        model_names = options[:all] ? get_all_model_names : classes

        get_models(model_names).each do |klass|
          Rails::Generators.invoke("factory_girl:model", [klass.to_s] + get_columns(klass) + ARGV)
        end
      end

      private

      def sanity_check
        if !options[:all] && classes.empty?
          self.class.help(Thor::Base.shell.new)
          exit
        elsif !Dir.exists? options[:model_dir]
          puts "Given model-dir doesn't exist (#{options[:model_dir]})"
          exit
        end
      end

      def get_models(model_names)
        model_names
          .map{|m| m.camelize.constantize}
          .select{|k| k.ancestors.include? ActiveRecord::Base }
      end

      def get_all_model_names
        Dir.chdir(options[:model_dir]) do
          Dir["**/*.rb"].map{|f| f.gsub(/\.rb$/, '')}
        end
      end

      def get_columns(klass)
        klass.columns.map{|c| "#{c.name}:#{c.type}" }
      end

    end
  end
end
