RSpec.describe SyncCatalogueData::Importers::HealthService do
  it "should initialize with options" do
    importer = SyncCatalogueData::Importers::HealthService.new({clear_existing_data: true})
    expect(importer.options).to eq({clear_existing_data: true})
  end

  context ".call" do
    before(:each) do
      ::HealthService = OpenStruct.new("create!" => true, destroy_all: true)
      allow(::HealthService).to receive(:create!)
      @file_path = File.join(SyncCatalogueData.root_path, "spec", "sample_files", "health_services-sample.csv")
      expect(File).to receive(:delete).with(@file_path).and_return(1)
      expect_any_instance_of(SyncCatalogueData::Downloaders::HealthService).to receive(:call).and_return(@file_path)
      csv_contents = File.read(@file_path)
      @csv = CSV.parse(csv_contents, :headers => true)
    end

    it "should import the downloaded file" do
      importer = SyncCatalogueData::Importers::HealthService.new
      expect(importer).to receive(:read_csv).with(@file_path).and_return(@csv)

      @csv.each do |row|
        data = row.to_hash
        attributes = {
          ha: data["HA"].to_s.strip,
          service: data["SERVICE"].to_s.strip,
          service_type: data["SERVICE_TYPE"].to_s.strip,
          m_20092010: data["M_20092010"].to_s.strip,
          f_20092010: data["F_20092010"].to_s.strip,
        }

        expect(::HealthService).to receive(:create!).with(attributes)
      end
      importer.call
    end

    context "with clear_existing_data option" do
      it "should delete all existing records" do
        importer = SyncCatalogueData::Importers::HealthService.new(clear_existing_data: true)
        expect(::HealthService).to receive(:destroy_all)
        importer.call
      end
    end
  end
end
