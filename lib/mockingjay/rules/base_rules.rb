module Mockingjay

  # These define basic rules for converting a deserialized value down to a generator
  module Rules
    class << self
      def fixnum
        {'Generator.fixnum' => '(1..100)'}
      end

      def float
        {'Generator.float' => '(1..100)'}
      end

      def string
        {'Generator.string' => 'Lorem.word'}
      end

      def unknown(type)
        {'Generator.unknown' => '#{type}'}
      end
    end
  end
end
