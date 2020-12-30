RSpec.describe SyncCatalogueData::Downloaders::HealthService do
  it "has a contant HEALTH_SERVICES_DATA_URL" do
    expect(SyncCatalogueData::Downloaders::HealthService::HEALTH_SERVICES_DATA_URL).to eq("https://catalogue.data.gov.bc.ca/dataset/a16d7095-9577-4c81-a800-33763ed75c8e/resource/b8fea73b-cb28-43aa-ab22-ce52e80f9941/download/bchealthservicesbygenderandhealthservicedeliveryarea.csv")
  end

  context ".call" do
    it "should call the importer services" do
      sample_file_path = File.join(SyncCatalogueData.root_path, "spec", "sample_files", "health_services-sample.csv")
      allow(URI).to receive(:open).with(SyncCatalogueData::Downloaders::HealthService::HEALTH_SERVICES_DATA_URL).and_return(File.open(sample_file_path))
      downloader = SyncCatalogueData::Downloaders::HealthService.new
      expect(downloader).to receive(:file_path_for).with("health_services").and_return(sample_file_path)
      expect(downloader.call).to eq(sample_file_path)
    end
  end
end
