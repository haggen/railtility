class Session
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Translation
  extend  ActiveModel::Naming

  attr_accessor :user, :email, :password

  validate do
    self.user = User.authenticate(email, password)

    if user == nil
      errors.add(:email, t "errors.messages.not_found")
    elsif user == false
      errors.add(:password, t "errors.messages.no_match")
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
