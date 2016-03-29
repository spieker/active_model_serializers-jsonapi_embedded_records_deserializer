require 'active_model_serializers/jsonapi_embedded_records_deserializer/version'
require 'active_model_serializers/adapter/json_api/deserialization'

module ActiveModelSerializers
  module JsonapiEmbeddedRecordsDeserializer
  end

  module Adapter
    class JsonApi
      module Deserialization
        module_function

        def parse_relationship(assoc_name, assoc_data, options)
          prefix_key = field_key(assoc_name, options).to_s.singularize
          hash =
            if (options[:embedded] || []).include?(assoc_name.to_sym)
              parse_nested_attributes(assoc_name, assoc_data, options)
            elsif assoc_data.is_a?(Array)
              { "#{prefix_key}_ids".to_sym => assoc_data.map { |ri| ri['id'] } }
            else
              { "#{prefix_key}_id".to_sym => assoc_data ? assoc_data['id'] : nil }
            end

          polymorphic = (options[:polymorphic] || []).include?(assoc_name.to_sym)
          hash["#{prefix_key}_type".to_sym] = assoc_data['type'] if polymorphic

          hash
        end

        def parse_nested_attributes(assoc_name, assoc_data, options)
          data =
            if assoc_data.is_a?(Array)
              assoc_data.map { |ri| parse({ 'data' => ri }, options) }
            else
              parse({ 'data' => assoc_data }, options)
            end
          { "#{assoc_name}_attributes".to_sym => data }
        end
      end
    end
  end
end
