require "quintype/seo/version"

module Quintype
  module Seo
    autoload :Base, "quintype/seo/base"

    def self.Base(args)
      clazz = Struct.new(*args.map(&:intern))
      clazz.send(:include, BaseFunctions)
      clazz
    end

    autoload :Home, "quintype/seo/home"
    autoload :Story, "quintype/seo/story"
    autoload :Section, "quintype/seo/section"
    autoload :StaticPage, "quintype/seo/static_page"
    autoload :Search, "quintype/seo/search"
    autoload :StoryElement, "quintype/seo/story_element"
    autoload :Tag, "quintype/seo/tag"
  end
end
