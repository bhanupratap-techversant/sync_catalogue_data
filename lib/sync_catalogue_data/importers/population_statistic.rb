require_relative "base_importer"

module SyncCatalogueData
  module Importers
    class PopulationStatistic < BaseImporter
      def call
        file_path = Downloaders::PopulationStatistic.new.call
        csv = read_csv(file_path)
        clear_existing_data_for(::PopulationStatistic) if options[:clear_existing_data]
        csv.each do |row|
          create_record(::PopulationStatistic, row)
        end
        File.delete(file_path)
      end

      private

      def serialized_attributes(data)
        {
          dimension: data["﻿Dimension "].to_s.strip,
          ha1_interior: data["HA 1 Interior"].to_s.strip,
          ha2_fraser: data["HA 2 Fraser"].to_s.strip,
          ha3_vancouver_caustal: data["HA 3 Vancouver Coastal"].to_s.strip,
          ha4_vancouver_island: data["HA 4 Vancouver Island"].to_s.strip,
          ha5_northern: data["HA 5 Northern"].to_s.strip,
        }
      end
    end
  end
end
