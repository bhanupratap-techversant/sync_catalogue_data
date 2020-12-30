require_relative "base_importer"

module SyncCatalogueData
  module Importers
    class HealthService < BaseImporter
      def call
        file_path = Downloaders::HealthService.new.call
        csv = read_csv(file_path)
        clear_existing_data_for(::HealthService) if options[:clear_existing_data]
        csv.each do |row|
          create_record(::HealthService, row)
        end
        File.delete(file_path)
      end

      private

      def serialized_attributes(data)
        {
          ha: data["HA"].to_s.strip,
          service: data["SERVICE"].to_s.strip,
          service_type: data["SERVICE_TYPE"].to_s.strip,
          m_20092010: data["M_20092010"].to_s.strip,
          f_20092010: data["F_20092010"].to_s.strip,
        }
      end
    end
  end
end
