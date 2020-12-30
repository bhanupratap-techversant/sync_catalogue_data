require_relative "base_downloader"

module SyncCatalogueData
  module Downloaders
    class HealthService < BaseDownloader
      HEALTH_SERVICES_DATA_URL = "https://catalogue.data.gov.bc.ca/dataset/a16d7095-9577-4c81-a800-33763ed75c8e/resource/b8fea73b-cb28-43aa-ab22-ce52e80f9941/download/bchealthservicesbygenderandhealthservicedeliveryarea.csv".freeze

      def call
        file_object = open(file_path_for("population_statistics"), 'wb') do |file|
          file << URI.open(POPULATION_STATISTICS_DATA_URL).read
        end
        file_object.path
      end
    end
  end
end
