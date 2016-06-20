module Quintype::Seo
  class Search < Quintype::Seo::Base
    attr_reader :term
    def initialize(config, term)
      super(config, 'search')
      @term = term
    end

    private

    def tags(metadata)
      title = get_title(metadata)
      {
        'title' => title
      }
    end

    def get_title(metadata)
      term + ' - Search Results'
    end
  end
end
