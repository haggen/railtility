require 'bcrypt'

module Authenticable
  extend ActiveSupport::Concern
  
  extend BCrypt

  included do
    attr_accessor :password, :password_confirmation

    validates :email, :presence => true, :uniqueness => true
    validates :password, :presence => true, :if => :requires_password?
    validates :password_confirmation, :presence => true, :if => :requires_password?
    validates :password, :confirmation => true, :if => :requires_password?

    before_save do
      unless password.blank?
        self.password_digest = Password.create(password)
      end
    end

    def requires_password?
      password_digest.blank?
    end

    def repeat_password?
      not password.blank?
    end

    def password_match?(password)
      Password.new(password_digest) == password
    end

    def self.authenticate(email, password)
      user = where(:email => email).first
      user.try(:password_match?, password) && user
    end
  end
end
