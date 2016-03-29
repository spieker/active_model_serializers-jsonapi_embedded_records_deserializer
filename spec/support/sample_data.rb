module SampleData
  def self.included(receiver)
    receiver.let(:referenced_records) do
      {
        'data' => {
          'type' => 'photos',
          'id' => 'zorglub',
          'attributes' => {
            'title' => 'Ember Hamster',
            'src' => 'http://example.com/images/productivity.png'
          },
          'relationships' => {
            'author' => {
              'data' => nil
            },
            'photographer' => {
              'data' => { 'type' => 'people', 'id' => '9' }
            },
            'comments' => {
              'data' => [
                { 'type' => 'comments', 'id' => '1' },
                { 'type' => 'comments', 'id' => '2' }
              ]
            }
          }
        }
      }
    end

    receiver.let(:embedded_records) do
      {
        'data' => {
          'type' => 'photos',
          'id' => 'zorglub',
          'attributes' => {
            'title' => 'Ember Hamster',
            'src' => 'http://example.com/images/productivity.png'
          },
          'relationships' => {
            'author' => {
              'data' => {
                'type' => 'author',
                'attributes' => {
                  'name' => 'John Doe'
                }
              }
            },
            'photographer' => {
              'data' => { 'type' => 'people', 'id' => '9' }
            },
            'comments' => {
              'data' => [
                { 'type' => 'comments', 'id' => '1' },
                { 'type' => 'comments', 'id' => '2' }
              ]
            }
          }
        }
      }
    end

    receiver.let(:deeply_embedded_records) do
      {
        'data' => {
          'type' => 'photos',
          'id' => 'zorglub',
          'attributes' => {
            'title' => 'Ember Hamster',
            'src' => 'http://example.com/images/productivity.png'
          },
          'relationships' => {
            'author' => {
              'data' => {
                'type' => 'author',
                'attributes' => {
                  'name' => 'John Doe'
                },
                'relationships' => {
                  'cameras' => {
                    'data' => [{
                      'type' => 'cameras',
                      'id' => 'nikon',
                      'attributes' => {
                        'manifacturer' => 'Nikon'
                      }
                    }, {
                      'type' => 'cameras',
                      'attributes' => {
                        'manifacturer' => 'Canon'
                      }
                    }]
                  }
                }
              }
            },
            'photographer' => {
              'data' => { 'type' => 'people', 'id' => '9' }
            },
            'comments' => {
              'data' => [
                { 'type' => 'comments', 'id' => '1' },
                { 'type' => 'comments', 'id' => '2' }
              ]
            }
          }
        }
      }
    end
  end
end

RSpec.configure do |config|
  config.include SampleData
end
