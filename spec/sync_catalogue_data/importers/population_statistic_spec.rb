RSpec.describe SyncCatalogueData::Importers::PopulationStatistic do
  it "should initialize with options" do
    importer = SyncCatalogueData::Importers::PopulationStatistic.new({clear_existing_data: true})
    expect(importer.options).to eq({clear_existing_data: true})
  end

  context ".call" do
    before(:each) do
      ::PopulationStatistic = OpenStruct.new("create!" => true)
      allow(::PopulationStatistic).to receive(:create!)
      @file_path = File.join(SyncCatalogueData.root_path, "spec", "sample_files", "population_statistics-sample.csv")
      expect(File).to receive(:delete).with(@file_path).and_return(1)
      expect_any_instance_of(SyncCatalogueData::Downloaders::PopulationStatistic).to receive(:call).and_return(@file_path)
      csv_contents = File.read(@file_path)
      @csv = CSV.parse(csv_contents, :headers => true)
    end

    it "should import the downloaded file" do
      importer = SyncCatalogueData::Importers::PopulationStatistic.new
      expect(importer).to receive(:read_csv).with(@file_path).and_return(@csv)

      @csv.each do |row|
        data = row.to_hash
        attributes = {
          dimension: data["﻿Dimension "].to_s.strip,
          ha1_interior: data["HA 1 Interior"].to_s.strip,
          ha2_fraser: data["HA 2 Fraser"].to_s.strip,
          ha3_vancouver_caustal: data["HA 3 Vancouver Coastal"].to_s.strip,
          ha4_vancouver_island: data["HA 4 Vancouver Island"].to_s.strip,
          ha5_northern: data["HA 5 Northern"].to_s.strip,
        }

        expect(::PopulationStatistic).to receive(:create!).with(attributes)
      end
      importer.call
    end

    context "with clear_existing_data option" do
      it "should delete all existing records" do
        importer = SyncCatalogueData::Importers::PopulationStatistic.new(clear_existing_data: true)
        expect(::PopulationStatistic).to receive(:destroy_all)
        importer.call
      end
    end
  end
end
