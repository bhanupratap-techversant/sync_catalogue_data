RSpec.describe SyncCatalogueData::Downloaders::PopulationStatistic do
  it "has a contant POPULATION_STATISTICS_DATA_URL" do
    expect(SyncCatalogueData::Downloaders::PopulationStatistic::POPULATION_STATISTICS_DATA_URL).to eq("https://catalogue.data.gov.bc.ca/dataset/ecc0b2fe-1287-46fd-8fc1-29dad621c0ce/resource/1665c496-7e16-487a-bb6a-54f05d166bc7/download/2016_census_profiles_by_health_region.csv")
  end

  context ".call" do
    it "should call the importer services" do
      sample_file_path = File.join(SyncCatalogueData.root_path, "spec", "sample_files", "population_statistics-sample.csv")
      allow(URI).to receive(:open).with(SyncCatalogueData::Downloaders::PopulationStatistic::POPULATION_STATISTICS_DATA_URL).and_return(File.open(sample_file_path))
      downloader = SyncCatalogueData::Downloaders::PopulationStatistic.new
      expect(downloader).to receive(:file_path_for).with("population_statistics").and_return(sample_file_path)
      expect(downloader.call).to eq(sample_file_path)
    end
  end
end
