module Quintype::Seo
  class StaticPage < Quintype::Seo::Base
    attr_reader :name, :title
    def initialize(config, name, title)
      super(config, 'static-page', name)
      @name = name
      @title = title
    end

    private

    def tags(metadata)
      {
        'title' => title
      }
    end
  end
end
