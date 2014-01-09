module Mockingjay
  class Deserialize
    attr_reader :data

    # Takes in a JSON string, and creates a new hash full of data
    def initialize(raw_data)
      @data = reduce_hash(JSON.parse(raw_data))
    end

    private

    # Reduces a hash into generated values by looking for Generator hooks
    def reduce_hash(data)
      data.each_pair.reduce({}) { |data, (key, value)|
        if (match = key.match(/Generator\.(?<f>.+)/))
          generator_for(match[:f], value)
        else
          data.merge!({ key.to_sym => interpret(value) })
        end
      }
    end

    def reduce_array(data)
      data.reduce([]) { |array, value| array << interpret(value) }
    end

    def interpret(value)
      case
      when value.class == Hash  then reduce_hash(value)
      when value.class == Array then reduce_array(value)
      end
    end

    # When given a generator, if it exists it will send data to it. If not, an unknown
    # generator will be called.
    def generator_for(type, args = nil)
      Generator.respond_to?(type) ? Generator.send(type, args) : Generator.unknown(type)
    end
  end
end
