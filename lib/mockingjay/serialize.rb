module Mockingjay
  class Serialize
    attr_reader :json

    # Parses raw data to JSON
    def initialize(raw_data)
      @json = reduce_hash(raw_data.is_a?(Hash) ? raw_data : JSON.parse(raw_data)).to_json
    end

    # A bit of sugar for quicker saves
    def save_as(name)
      File.open("#{name}.json", 'w') { |file| file.write @json }
    end

    private

    def reduce_hash(data)
      data.each_pair.reduce({}) { |data, (key, value)| data.merge!({ key => interpret(value) }) }
    end

    def reduce_array(data)
      data.reduce([]) { |array, value| array << interpret(value) }
    end

    def interpret(value)
      case
      when value.class == Hash  then reduce_hash(value)
      when value.class == Array then reduce_array(value)
      else generator_for(value)
      end
    end

    # Finds the type of a value, and turns into a symbol to hook rules
    def value_type_of(value)
      value.class.to_s.downcase.to_sym
    end

    # Finds the rule to substitute in place of a value
    def generator_for(value)
      type = value_type_of(value)
      Generator.respond_to?(type) ? Rules.send(type) : Rules.unknown(type)
    end
  end
end
