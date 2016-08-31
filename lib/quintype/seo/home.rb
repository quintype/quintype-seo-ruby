module Quintype::Seo
  class Home < Quintype::Seo::Base

    def initialize(config)
      super(config, 'home')
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
        },
        'msvalidate.01' => Rodash.get(config, ['integrations', 'bing', 'app-id']),
        'fb' => {
          'app-id' => Rodash.get(config, ['facebook', 'app-id'])
        },
        'alternate' => [{
          'href' => '/feed',
          'type' => 'application/atom+xml',
          'title' => "#{title} ATOM Feed"
        }]
      })
    end

    def get_title(metadata)
      metadata['page-title'].presence || config['title']
    end
  end
end
