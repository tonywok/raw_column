require "raw_column/version"
require "raw_column/json_proxy"

module RawColumn

  extend ActiveSupport::Concern

  module ClassMethods

    def raw_column(*column_names)
      class_eval do
        column_names = [:content] if column_names.nil?
        column_names.each do |column_name|
          define_method :"raw_#{column_name}" do
            JsonProxy.new(self, column_name)
          end
        end
      end
    end

  end
end
