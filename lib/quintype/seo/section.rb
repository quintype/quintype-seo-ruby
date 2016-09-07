module Quintype::Seo
  class Section < Quintype::Seo::Base
    attr_reader :section
    def initialize(config, section)
      super(config, 'section', section['id'])
      @section = section
    end

    private

    def tags(metadata)
      title = get_title(metadata)
      metadata.except('page-title').merge({
        'title' => title,
        'description' => metadata['description'],
        'og' => {
          'title' => metadata['title'],
          'description' => metadata['description']
        },
        'twitter' => {
          'title' => metadata['title'],
          'description' => metadata['description']
        }
      })
    end

    def get_title(metadata)
      metadata['page-title'].presence || make_hyphenated_title
    end

    def make_hyphenated_title
      (section['display-name'] || section['name']) + " - " + (config['title'] || '')
    end
  end
end
