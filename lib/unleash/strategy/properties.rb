module Unleash
  module Strategy
    class Properties < Base
      PROPERTY_PARAM = 'property'
      VALUE_PARAM = 'value'

      def name
        'properties'
      end

      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.has_key?(PROPERTY_PARAM) && params.has_key?(VALUE_PARAM)
        return false unless params.fetch(PROPERTY_PARAM, nil).is_a? String
        return false unless params.fetch(VALUE_PARAM, nil).is_a? String
        return false unless context.class.name == 'Unleash::Context'

        possible_values = params[VALUE_PARAM].split(",").map(&:strip)
        context_key = params[PROPERTY_PARAM]
        # indifferent access
        context_value = (context.properties[context_key] || context.properties[context_key.to_sym])&.to_s

        possible_values.include? context_value
      end
    end
  end
end
