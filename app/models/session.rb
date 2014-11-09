class Session < ActiveModel::Model

  attr_accessor :user, :email, :password

  validate do
    self.user = User.authenticate(email, password)

    case user
    when nil then errors.add(:email, :not_found)
    when false then errors.add(:password, :no_match)
    end
  end
end
