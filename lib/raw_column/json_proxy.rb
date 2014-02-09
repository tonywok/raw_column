module RawColumn

  class TypeCastError < StandardError; end

  class JsonProxy

    def initialize(record, column_name)
      method = :"#{column_name}_before_type_cast"
      unless record.respond_to?(method)
        raise BeforeTypeCastError.new("your column must respond to #{method}")
      end
      @raw_content = record.send(method)
    end

    def as_json(*args)
      self
    end

    def encode_json(encoder)
      @raw_content
    end

  end
end
