module RawColumn

  class JsonProxy

    def initialize(record, column_name)
      @raw_content = record.send(:"#{column_name}_before_type_cast")
    end

    def as_json(*args)
      self
    end

    def encode_json(encoder)
      @raw_content
    end

  end
end
