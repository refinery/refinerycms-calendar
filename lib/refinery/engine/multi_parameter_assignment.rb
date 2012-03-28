module Refinery
  module Engine
    module MultiparameterAssignment
      def setup_parameters(params = {})
        new_params = {}
        multi_parameter_attributes = []

        params.each do |k,v|
          if k.to_s.include?("(")
            multi_parameter_attributes << [ k.to_s, v ]
          else
            new_params[k.to_s] = v
          end
        end

        new_params.merge(assign_multiparameter_attributes(multi_parameter_attributes))
      end

      def execute_callstack_for_multiparameter_attributes(callstack)
        errors = []
        callstack.each do |name, values_with_empty_parameters|
          begin
            send(name + "=", read_value_from_parameter(name, values_with_empty_parameters))
          rescue => ex
            errors << AttributeAssignmentError.new("error on assignment #{values_with_empty_parameters.values.inspect} to #{name}", ex, name)
          end
        end
        unless errors.empty?
          raise MultiparameterAssignmentErrors.new(errors), "#{errors.size} error(s) on assignment of multiparameter attributes"
        end
      end

      def assign_multiparameter_attributes(pairs)
        execute_callstack_for_multiparameter_attributes(
          extract_callstack_for_multiparameter_attributes(pairs)
        )
      end

      def extract_callstack_for_multiparameter_attributes(pairs)
        attributes = { }

        pairs.each do |pair|
          multiparameter_name, value = pair
          attribute_name = multiparameter_name.split("(").first
          attributes[attribute_name] = {} unless attributes.include?(attribute_name)

          parameter_value = value.empty? ? nil : type_cast_attribute_value(multiparameter_name, value)
          attributes[attribute_name][find_parameter_position(multiparameter_name)] ||= parameter_value
        end

        attributes
      end

      def type_cast_attribute_value(multiparameter_name, value)
        multiparameter_name =~ /\([0-9]*([if])\)/ ? value.send("to_" + $1) : value
      end

      def find_parameter_position(multiparameter_name)
        multiparameter_name.scan(/\(([0-9]*).*\)/).first.first.to_i
      end
    end
  end
end
