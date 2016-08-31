module Quintype::Seo
  class Story < Quintype::Seo::Base
    attr_reader :story
    def initialize(config, story)
      super(config, 'story', story['slug'])
      @story = story
    end

    private

    def tags(metadata)
      title = get_title(metadata)
      metadata.except('page-title').merge({
        'title' => title,
        'description' => story['summary'],
        'og' => og_attributes,
        'twitter' => twitter_attributes,
        'fb' => {
          'app_id' => Rodash.get(config, ['facebook', 'app-id'])
        },
        'article' => {
          'publisher' => Rodash.get(config , ['social-links', 'facebook-url'])
        },
        'msvalidate.01' => Rodash.get(config, ['integrations', 'bing', 'app-id']),
        'canonical' => API::URL.story_canonical(config['sketches-host'], story),
        'al:android:package' => Rodash.get(config, ['apps-data', 'al:android:package']),
        'al:android:app_name' => Rodash.get(config, ['apps-data', 'al:android:app_name']),
        'al:android:url' => "quintypefb://#{config['host']}/#{story['slug']}"
      })
    end

    def twitter_attributes
      {
        'title' => story['headline'],
        'description' => story['summary'],
        'card' => 'summary-large-image',
        'site' => Rodash.get(config, ['social-app-credentials', 'twitter', 'username']),
        'image' => {
          'src' => hero_image_url
        }
      }
    end

    def og_attributes
      hash = {
        'title' => story['headline'],
        'type' => 'article',
        'url' => API::URL.story_canonical(config['sketches-host'], story),
        'site_name' => config['title'],
        'description' => story['summary'],
        'image' => (config['cdn-name'] + story['hero-image-s3-key']).gsub(" ", "%20")
      }
      if hero_image_metadata = story['hero-image-metadata'].presence
        hash.merge!("image:width" => hero_image_metadata["width"]) if hero_image_metadata["width"]
        hash.merge!("image:height" => hero_image_metadata["height"]) if hero_image_metadata["height"]
      end
      hash
    end

    def hero_image_url
      (config['cdn-name'] + story['hero-image-s3-key']).gsub(" ", "%20")
    end

    def get_title(metadata)
      metadata['page-title'].presence || make_hyphenated_title
    end

    def make_hyphenated_title
      story['headline'] + " - " + config['title']
    end
  end
end
