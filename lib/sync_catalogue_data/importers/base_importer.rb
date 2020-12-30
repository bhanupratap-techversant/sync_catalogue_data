require 'csv'

module SyncCatalogueData
  module Importers
    class BaseImporter
      attr_reader :options

      def initialize(options={})
        @options = options
      end

      private

      def create_record(model, row)
        attributes = serialized_attributes(row.to_hash)
        model.create!(attributes)
      end

      def clear_existing_data_for(model)
        model.destroy_all
      end

      def read_csv(file_path)
        csv_contents = File.read(file_path)
        CSV.parse(csv_contents, :headers => true)
      end

      def serialized_attributes(data)
        raise "Need to overload in child class!"
      end
    end
  end
end
