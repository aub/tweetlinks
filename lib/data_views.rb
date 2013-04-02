module DataViews
  extend ActiveSupport::Concern

  module ClassMethods
    def data_view(name, &block)
      if Hash === name
        raise ArgumentError, "Multi-valued hash not allowed." unless name.length == 1
        parent = get_data_view(name.values.first)
        name = name.keys.first.to_sym
      else
        name = name.to_sym
      end
      data_views[name] = View.new(name, parent, &block)
    end

    def get_data_view(name) #:nodoc:
      name = name.to_sym
      return data_views[name] if data_views.has_key?(name)
      superclass.get_data_view(name) if superclass.respond_to?(:data_view)
    end

    private

    def data_views
      @data_views ||= {}
    end
  end

  def with_data_view(name)
    self.class.get_data_view(name).try(:extract, self)
  end

  class View
    attr_reader :name

    def initialize(name, parent, &block)
      @name = name
      @parent = parent
      @properties = []
      instance_eval(&block)
    end

    def extract(object)
      (@parent ? @parent.extract(object) : {}).tap do |data|
        @properties.each do |property|
          value = property.extract(object)
          data[property.name] = value
        end
      end
    end

    private

    def property(*names, &extractor)
      options = names.extract_options!
      names.each do |name|
        @properties << Property.new(name, options, extractor, self)
      end
    end
  end

  class Property
    attr_reader :name

    def initialize(name, options, extractor, view)
      @name, @options, @extractor, @view = name.to_sym, options, extractor, view
    end

    def extract(object)
      construct_object(
        @extractor ? object.instance_eval(&@extractor) : object.__send__(name)
      )
    end

    private

    def construct_object(source)
      case source
      when nil then nil
      when Array then source.map { |element| construct_object(element) }
      when DataViews then source.with_data_view(@view.name)
      else source
      end
    end
  end
end
