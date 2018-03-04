module Infrastructure
  class Command
    include ActiveModel::Model
    include ActiveModel::Validations
    include ActiveModel::Conversion

    class ValidationError < StandardError
      attr_reader :errors

      def initialize(errors)
        super()
        @errors = errors
      end
    end

    def initialize(attributes={})
      super
    end

    def validate!
      raise ValidationError, errors unless valid?
    end

    def persisted?
      false
    end
  end
end
