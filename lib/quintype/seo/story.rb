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
      metadata.except('page_title').merge({
        'title' => title,
        'description' => Rodash.get(story, ['seo', 'meta_description']).presence || story['summary'],
        'og' => og_attributes,
        'twitter' => twitter_attributes,
        'fb' => {
          'app_id' => Rodash.get(config, ['facebook', 'app_id'])
        },
        'article' => {
          'publisher' => Rodash.get(config , ['social_links', 'facebook_url'])
        },
        'msvalidate.01' => Rodash.get(config, ['integrations', 'bing', 'app_id']),
        'canonical' => API::URL.story_canonical(config['root_url'], story),
        'al:android:package' => Rodash.get(config, ['apps_data', 'al:android:package']),
        'al:android:app_name' => Rodash.get(config, ['apps_data', 'al:android:app_name']),
        'al:android:url' => "quintypefb://#{config['host']}/#{story['slug']}"
      })
    end

    def twitter_attributes
      {
        'title' => story['headline'],
        'description' => story['summary'],
        'card' => 'summary_large_image',
        'site' => Rodash.get(config, ['social_app_credentials', 'twitter', 'username']),
        'image' => {
          'src' => hero_image_url
        }
      }
    end

    def og_attributes
      hash = {
        'title' => story['headline'],
        'type' => 'article',
        'url' => API::URL.story_canonical(config['root_url'], story),
        'site_name' => config['title'],
        'description' => story['summary'],
        'image' => (config['cdn_name'] + story['hero_image_s3_key']).gsub(" ", "%20")
      }
      if hero_image_metadata = story['hero_image_metadata'].presence
        hash.merge!("image:width" => hero_image_metadata["width"]) if hero_image_metadata["width"]
        hash.merge!("image:height" => hero_image_metadata["height"]) if hero_image_metadata["height"]
      end
      hash
    end

    def hero_image_url
      (config['cdn_name'] + story['hero_image_s3_key']).gsub(" ", "%20")
    end

    def get_title(metadata)
      Rodash.get(story, ['seo', 'meta_title']).presence || make_hyphenated_title
    end

    def make_hyphenated_title
      story['headline'] + " - " + config['title']
    end
  end
end
