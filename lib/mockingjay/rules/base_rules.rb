module Mockingjay
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
