class User < ActiveRecord::Base

  has_and_belongs_to_many :roles
  belongs_to :person

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,  :authentication_keys => [:login]

  attr_accessor :login
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids, :username, :login, :person_id

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
