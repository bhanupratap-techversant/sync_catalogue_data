require_relative "base_downloader"

module SyncCatalogueData
  module Downloaders
    class PopulationStatistic < BaseDownloader
      POPULATION_STATISTICS_DATA_URL = "https://catalogue.data.gov.bc.ca/dataset/ecc0b2fe-1287-46fd-8fc1-29dad621c0ce/resource/1665c496-7e16-487a-bb6a-54f05d166bc7/download/2016_census_profiles_by_health_region.csv".freeze

      def call
        file_object = open(file_path_for("population_statistics"), 'wb') do |file|
          file << URI.open(POPULATION_STATISTICS_DATA_URL).read
        end
        file_object.path
      end
    end
  end
end
