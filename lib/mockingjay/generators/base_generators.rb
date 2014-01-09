module Mockingjay
  # Eventually this should start searching through a folder of other fixtures to
  # see if they know how to make an object.
  #
  # Takes Generator hooks in serialized data and returns values.
  module Generator
    class << self
      include Faker

      def fixnum(str_range)
        a, b = *str_range.split(/...?/).map(&:to_i)
        b ? rand(a..b).to_i : rand(a).to_i
      end

      def float(str_range)
        a, b = *str_range.split(/...?/).map(&:to_i)
        b ? rand(a..b) : rand(a)
      end

      # Anything that you can use in faker, you can use here.
      #
      # https://github.com/stympy/faker
      def string(type = 'Lorem.word')
        self.instance_eval type
      end

      # Date Time will need some work, for now leaving this commented out.

      # def date(str_range); time(str_range); end

      # def time(str_range)
      #   a, b = *str_range.split('..')
      #   b ? time_rand(a,b) : time_rand(a)
      # end

      def unknown(type)
        "Unknown Generator Type #{type}"
      end

      private

      # def time_rand(from = 0.0, to = Time.now)
      #   Time.at(from + rand * (to.to_f - from.to_f))
      # end
    end
  end
end
