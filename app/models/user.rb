class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :role, :password, :password_confirmation, :password_digest, :comment_ids

  has_many :comments, as: :commentable

  validates :password, :presence => { :on => :create }
  validates_uniqueness_of :email, :message => "Sorry, that e-mail address already belongs to an existing account."

    USER_ROLES = {
    :admin => 0,
    :student => 10
  }


  def set_as_admin 
    self.role = USER_ROLES[:admin]
  end

  def set_as_student 
    self.role = USER_ROLES[:student]
  end
  
  def admin?
    true if self.role_name == :admin
  end

  def owns?(material)
    true if self.id == material.user_id
  end

  def self.admin
    User.where(:role => USER_ROLES[:admin])
  end

  def role_name
    User.user_roles.key(self.role)
  end

  def can_edit?(material)
    true if admin? || owns?(material)
  end

  def can_destroy?(material)
    true if admin? || owns?(material)
  end
end
