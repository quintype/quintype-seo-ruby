module Quintype::Seo
  class Base
    attr_reader :config, :page_type, :page_identifier, :grouped_metadata

    def initialize(config, page_type, page_identifier = nil)
      @config = config
      @page_type = page_type
      @page_identifier = page_identifier
      @grouped_metadata = group_metadata(config['seo_metadata'])
    end

    def to_h
      tags(page_metadata)
    end

    def tags(metadata)
      raise 'Implement this in a child class!'
    end

    private

    def page_metadata
      Rodash.get(grouped_metadata, [[page_type, page_identifier], 0, 'data'], {})
    end

    def group_metadata(metadata)
      metadata.group_by { |m| [m['owner_type'], m['owner_id']] }
    end
  end
end
