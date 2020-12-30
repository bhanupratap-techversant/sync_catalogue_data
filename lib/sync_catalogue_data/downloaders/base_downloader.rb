require 'open-uri'
require 'fileutils'

module SyncCatalogueData
  module Downloaders
    class BaseDownloader

      private

      def file_path_for(file_name)
        temp_path = File.join(SyncCatalogueData.root_path, "temp")
        FileUtils.mkdir_p(temp_path) unless Dir.exists?(temp_path)

        File.join(SyncCatalogueData.root_path, "temp", "#{file_name}-#{Time.now.to_s}.csv")
      end
    end
  end
end
