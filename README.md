# SyncCatalogueData

SyncCatalogueData is used to fetch data from below government authorized websites and import in your database.

1.
Population Statistics for British Columbia
(https://catalogue.data.gov.bc.ca/dataset/2016-census-semi-custom-profile-health-regions-of-british-columbia/resource/1665c496-7e16-487a-bb6a-54f05d166bc7)

2.
Health Services Expenditure for British Columbia
(https://catalogue.data.gov.bc.ca/dataset/bc-health-services-patient-counts-and-expenditures-by-gender-health-service-delivery-area-and-fiscal/resource/b8fea73b-cb28-43aa-ab22-ce52e80f9941)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sync_catalogue_data'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sync_catalogue_data

## Usage

To download the CSV files from government sites
```ruby
SyncCatalogueData::Downloaders::PopulationStatistic.new.call
SyncCatalogueData::Downloaders::HealthService.new.call
```

To download the CSV files from government sites and import in your DB.
```ruby
SyncCatalogueData.Importer.call

```
To delete existing records before importing the downloaded file.
```ruby
SyncCatalogueData.Importer.call(clear_existing_data: true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sync_catalogue_data. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/sync_catalogue_data/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SyncCatalogueData project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sync_catalogue_data/blob/master/CODE_OF_CONDUCT.md).
