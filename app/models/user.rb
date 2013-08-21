class User < ActiveRecord::Base
  has_secure_password
  acts_as_reader

  before_create { generate_token(:auth_token) }

  attr_accessible :email, :role, :password, :password_confirmation, :password_digest, :full_name, :username, :image, :facebook, :twitter, :linkedin
  attr_accessible :comment_ids

  has_many :comments, as: :commentable
  has_many :announcements
  
  mount_uploader :image, ImageUploader

  validates :password,  :presence => { :on => :create }
  validates :full_name, :presence => { :message => "can't be blank" }
  validates :email,     :presence => { :message => "can't be blank" }

  # validates_uniqueness_of :full_name, :message => "belongs to an existing account"
  validates_uniqueness_of :email,     :message => "belongs to an existing account"
  
  searchable do
    text :full_name, :facebook, :linkedin, :twitter, :email
  end


  USER_ROLES = {
    :admin => 0,
    :student => 10
  }

  def print_name
    username
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


  def set_as_admin 
    self.role = USER_ROLES[:admin]
  end

  def set_as_student 
    self.role = USER_ROLES[:student]
  end
  
  def admin?
    true if self.role_name == :admin
  end

  def student?
    true if self.role_name == :student
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

  def self.user_roles
    USER_ROLES
  end

  def can_edit?(material)
    true if admin? || owns?(material)
  end

  def can_destroy?(material)
    true if admin? || owns?(material)
  end
end
