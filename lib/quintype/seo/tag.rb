module Quintype::Seo
  class Tag < Quintype::Seo::Base
    attr_reader :tag
    def initialize(config, tag)
      super(config, 'tag', tag)
      @tag = tag
    end

    private

    def tags(metadata)
      title = get_title(metadata)
      {
        'title' => title
      }
    end

    def get_title(metadata)
      tag + ' - ' + (config['title'] || '')
    end
  end
end
