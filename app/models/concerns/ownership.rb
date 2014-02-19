module Ownership
  extend ActiveSupport::Concern

  CLASS_NAME = 'User'

  module ClassMethods
    def belongs_to_owner(options = {})
      belongs_to :owner, options.merge(:class_name => CLASS_NAME)
    end

    def owners_many(name, options = {})
      has_many name, options.merge(:inverse_of => :owner)
    end

    def owners_one(name, options = {})
      has_many name, options.merge(:inverse_of => :owner)
    end
  end
end