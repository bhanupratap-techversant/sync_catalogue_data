require 'csv'

# TODO: We can make a separate importer for each model.
# TODO: File should be deleted after completing the import process.
module SyncCatalogueData
  class Importer
    class << self
      def import_population_statistic_data(options)
        file_path = SyncCatalogueData::Downloader.download_population_data
        csv = read_csv(file_path)
        clear_existing_data_for(PopulationStatistic) if options[:clear_existing_data]
        csv.each do |row|
          create_population_statistic(row)
        end
      end

      def import_health_services_data(options)
        file_path = SyncCatalogueData::Downloader.download_health_services_data
        csv = read_csv(file_path)
        clear_existing_data_for(HealthService) if options[:clear_existing_data]
        csv.each do |row|
          create_health_service(row)
        end
      end

      private

      def create_population_statistic(row)
        attributes = population_statistic_attributes(row.to_hash)
        PopulationStatistic.create!(attributes)
      end

      def create_health_service(row)
        attributes = health_service_attributes(row.to_hash)
        HealthService.create!(attributes)
      end

      def population_statistic_attributes(data)
        {
          dimension: data["﻿Dimension "],
          ha1_interior: data["HA 1 Interior"],
          ha2_fraser: data["HA 2 Fraser"],
          ha3_vancouver_caustal: data["HA 3 Vancouver Coastal"],
          ha4_vancouver_island: data["HA 4 Vancouver Island"],
          ha5_northern: data["HA 5 Northern"],
        }
      end

      def health_service_attributes(data)
        {
          ha: data["HA"],
          service: data["SERVICE"],
          service_type: data["SERVICE_TYPE"],
          m_20092010: data["M_20092010"],
          f_20092010: data["F_20092010"],
        }
      end

      def clear_existing_data_for(model)
        model.destroy_all
      end

      def read_csv(file_path)
        csv_contents = File.read(file_path)
        CSV.parse(csv_contents, :headers => true)
      end
    end
  end
end
