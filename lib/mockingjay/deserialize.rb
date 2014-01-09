module Mockingjay
  class Deserialize
    attr_reader :data

    def initialize(raw_data)
      @data = reduce_hash(
        JSON.parse(
          raw_data.is_a?(Hash) ? File.open(raw_data[:file],'r').read : raw_data
        )
      )
    end

    private

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

    def generator_for(type, args = nil)
      Generator.respond_to?(type) ? Generator.send(type, args) : Generator.unknown(type)
    end
  end
end
