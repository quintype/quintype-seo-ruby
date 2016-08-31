module Quintype::Seo
  class StoryElement < Quintype::Seo::Base
    attr_reader :story, :story_element
    def initialize(config, story, story_element)
      super(config, 'story-element')
      @story = story
      @story_element = story_element
    end

    private

    def tags(metadata)
      title = get_title(metadata)
      metadata.except('page-title').merge({
        'title' => title,
        'canonical' => API::URL.story_canonical(config['sketches-host'], story),
      })
    end

    def get_title(metadata)
      story['headline'] + " - " + config['title']
    end
  end
end
