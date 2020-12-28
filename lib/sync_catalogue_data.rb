require "sync_catalogue_data/version"
require "sync_catalogue_data/downloader"

module SyncCatalogueData
  class Download
    def self.population_data
      SyncCatalogueData::Downloader.download_population_data
    end

    def self.health_services_data
      SyncCatalogueData::Downloader.download_health_services_data
    end

    def self.all
      SyncCatalogueData::Downloader.download_all
    end
  end
end
