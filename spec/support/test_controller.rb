class TestController < ActionController::Base
  def render_parsed_payload_with_nested_attributes
    options     = { nested_attributes: [:author, :cameras] }
    parsed_hash = ActiveModelSerializers::Deserialization.jsonapi_parse(params, options)
    render json: parsed_hash
  end
end
