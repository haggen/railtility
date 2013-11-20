require 'bcrypt'

module Authenticable
  extend ActiveSupport::Concern
  extend BCrypt

  included do
    attr_accessor :password, :password_confirmation

    validates_presence_of :password, :if => :requires_password?
    validates_presence_of :password_confirmation, :if => :repeat_password?
    validates_confirmation_of :password, :if => :repeat_password?
    validates :email, :presence => true, :uniqueness => true

    before_save do
      unless password.blank?
        self.password_digest = Password.create(password)
      end
    end

    def requires_password?
      password_digest.blank?
    end

    def repeat_password?
      requires_password? && !password.blank?
    end

    def password_match?(password)
      Password.new(password_digest) == password
    end

    def self.authenticate(email, password)
      user = find_by(:email => email)
      user.try(:password_match?, password) && user
    end
  end
end
