class Session
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Translation
  extend  ActiveModel::Naming

  attr_accessor :user, :email, :password

  validate do
    self.user = User.authenticate(email, password)

    case user
      when nil errors.add(:email, :not_found)
      when false errors.add(:password, :no_match)
    end
  end

  def persisted?
    false
  end

  def initialize(attributes = {})
    attributes && attributes.each do |name, value|
      send("#{name}=", value) if respond_to? name.to_sym
    end
  end
end
