require "sync_catalogue_data/version"

module SyncCatalogueData
  module Downloaders
    autoload :BaseDownloader, "sync_catalogue_data/downloaders/base_downloader"
    autoload :PopulationStatistic, "sync_catalogue_data/downloaders/population_statistic"
    autoload :HealthService, "sync_catalogue_data/downloaders/health_service"
  end

  module Importers
    autoload :BaseImporter, "sync_catalogue_data/importers/base_importer"
    autoload :PopulationStatistic, "sync_catalogue_data/importers/population_statistic"
    autoload :HealthService, "sync_catalogue_data/importers/health_service"
  end

  class Importer
    def self.call(options={})
      Importers::PopulationStatistic.new(options).call
      Importers::HealthService.new(options).call
    end
  end

  def self.root_path
    path = File.dirname __dir__
    path.gsub("/lib", "/")
  end
end
