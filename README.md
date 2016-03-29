# ActiveModelSerializers::JsonapiEmbeddedRecordsDeserializer

In some cases it is required to embed records into a relationship when creating
or maybe even when updating a record. The JSONAPI spec currently doesn't support
this but since a relationship contains a `data` part containing record objects,
it seems to be a possible way to include data there.

This gem extends the deserializer of ActiveModelSerializers to deserialize
relationships with embedded data into ActiveRecord nested attributes. The code
is extracted from the pull request [#1614](https://github.com/rails-api/active_model_serializers/pull/1614) of
ActiveModelSerializers.

### Example

The input data contains an author with embedded data.

```json
{
  "data": {
    "type": "photos",
    "id": "zorglub",
    "attributes": {
      "title": "Ember Hamster",
      "src": "http://example.com/images/productivity.png"
    },
    "relationships": {
      "author": {
        "data": {
          "type": "author",
          "attributes": {
            "name": "John Doe"
          }
        }
      }
    }
  }
}
```

When using the deserializer, the relationship `author` must be marked as embedded.

```ruby
ActiveModelSerializers::Deserialization.jsonapi_parse(data, embedded: [:author])
```

The result of the deserialization contains the `author_attributes` key as
expected by ActiveRecord containing the nested attributes.

```ruby
{
  id: 'zorglub',
  title: 'Ember Hamster',
  src: 'http://example.com/images/productivity.png',
  author_attributes: {
    name: 'John Doe'
  }
}
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_model_serializers-jsonapi_embedded_records_deserializer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_serializers-jsonapi_embedded_records_deserializer

## Usage

To support embedded records, the relationship expecting embedded data must be
specified in the `embedded` key of the deserialization options.

```ruby
ActiveModelSerializers::Deserialization.jsonapi_parse(data, embedded: [:author])
```

The deserialization part of ActiveModelSerializer is restructured between
`0.10.0.rc4` and the current `master` branch. Please check the version table
below to choose the right gem version.

| ActiveModelSerializer version | Gem version |
|-------------------------------|-------------|
| 0.10.0.rc4                    | 0.1.0       |
| master (currently: c7b2916)   | 0.1.1       |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/spieker/active_model_serializers-jsonapi_embedded_records_deserializer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
