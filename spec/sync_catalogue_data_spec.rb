RSpec.describe SyncCatalogueData do
  it "has a version number" do
    expect(SyncCatalogueData::VERSION).not_to be nil
  end

  describe SyncCatalogueData::Importer do
    context ".call" do
      it "should call the importer services" do
        expect_any_instance_of(SyncCatalogueData::Importers::PopulationStatistic).to receive(:call)
        expect_any_instance_of(SyncCatalogueData::Importers::HealthService).to receive(:call)
        SyncCatalogueData::Importer.call
      end
    end
  end
end
