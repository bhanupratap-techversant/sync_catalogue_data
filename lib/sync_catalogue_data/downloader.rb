require 'open-uri'
require 'fileutils'

module SyncCatalogueData
  class Downloader
    POPULATION_STATISTICS_DATA_URL = "https://catalogue.data.gov.bc.ca/dataset/ecc0b2fe-1287-46fd-8fc1-29dad621c0ce/resource/1665c496-7e16-487a-bb6a-54f05d166bc7/download/2016_census_profiles_by_health_region.csv".freeze
    HEALTH_SERVICES_DATA_URL = "https://catalogue.data.gov.bc.ca/dataset/a16d7095-9577-4c81-a800-33763ed75c8e/resource/b8fea73b-cb28-43aa-ab22-ce52e80f9941/download/bchealthservicesbygenderandhealthservicedeliveryarea.csv".freeze

    class << self
      def download_population_data
        file_object = open(file_path_for("population_statistics"), 'wb') do |file|
          file << URI.open(POPULATION_STATISTICS_DATA_URL).read
        end
        file_object.path
      end

      def download_health_services_data
        file_object = open(file_path_for("health_services"), 'wb') do |file|
          file << URI.open(HEALTH_SERVICES_DATA_URL).read
        end
        file_object.path
      end

      def download_all
        [
          download_population_data,
          download_health_services_data,
        ]
      end
    end

    private

    def self.file_path_for(file_name)
      temp_path = File.join(SyncCatalogueData.root_path, "temp")
      FileUtils.mkdir_p(temp_path) unless Dir.exists?(temp_path)

      File.join(SyncCatalogueData.root_path, "temp", "#{file_name}-#{Time.now.to_s}.csv")
    end
  end

  def self.root_path
    path = File.dirname __dir__
    path.gsub("/lib", "/")
  end
end
