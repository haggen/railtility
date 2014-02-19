module Authorship
  extend ActiveSupport::Concern

  CLASS_NAME = 'User'

  module ClassMethods
    def belongs_to_author(options = {})
      belongs_to :author, options.merge(:class_name => CLASS_NAME)
    end

    def authors_many(name, options = {})
      has_many name, options.merge(:inverse_of => :author)
    end

    def authors_one(name, options = {})
      has_many name, options.merge(:inverse_of => :author)
    end
  end
end