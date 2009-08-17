module Graft
  module Json
    class Attribute

      attr_reader :name, :source

      def initialize(name, source = nil)
        @name   = name
        @source = source.nil? ? @name.to_s : source
      end

      def value_from(json_data_or_hash)
        # TODO: remove this and assume that we're always dealing w/ a hash?
        data = json_data_or_hash.is_a?(String) ? JSON.parse(json_data_or_hash) : json_data_or_hash

        source.to_s.split('/').inject(data) do |data, key|
          (data.is_a?(Hash) && data[key]) ? data[key] : nil
        end
      end

    end
  end
end