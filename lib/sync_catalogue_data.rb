require "sync_catalogue_data/version"
require "sync_catalogue_data/downloader"
require "sync_catalogue_data/importer"

module SyncCatalogueData
  class Importer
    def self.call(options={})
      SyncCatalogueData::Importer.import_population_statistic_data(options)
      SyncCatalogueData::Importer.import_health_services_data(options)
    end
  end
end
