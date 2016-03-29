require 'spec_helper'

describe ActiveModelSerializers::JsonapiEmbeddedRecordsDeserializer do
  it 'has a version number' do
    expect(ActiveModelSerializers::JsonapiEmbeddedRecordsDeserializer::VERSION).not_to be nil
  end

  attr_reader :body

  def deserialize(data, options = {})
    @body = ActiveModelSerializers::Deserialization.jsonapi_parse(data, options)
  end

  it 'deserializes JSONAPI data' do
    deserialize referenced_records
    expect(body).to eql({
      id: 'zorglub',
      title: 'Ember Hamster',
      src: 'http://example.com/images/productivity.png',
      author_id: nil,
      photographer_id: '9',
      comment_ids: %w(1 2)
    })
  end

  describe 'with embedded records' do
    it 'deserializes nested attributes' do
      deserialize embedded_records, embedded: [:author]
      expect(body).to eql({
        id: 'zorglub',
        title: 'Ember Hamster',
        src: 'http://example.com/images/productivity.png',
        author_attributes: {
          name: 'John Doe'
        },
        photographer_id: '9',
        comment_ids: %w(1 2)
      })
    end

    it 'deserializes deeply nested attributes' do
      deserialize deeply_embedded_records, embedded: [:author, :cameras]
      expect(body).to eql({
        id: 'zorglub',
        title: 'Ember Hamster',
        src: 'http://example.com/images/productivity.png',
        author_attributes: {
          name: 'John Doe',
          cameras_attributes: [
            { id: 'nikon', manifacturer: 'Nikon' },
            { manifacturer: 'Canon' }
          ]
        },
        photographer_id: '9',
        comment_ids: %w(1 2)
      })
    end
  end
end
