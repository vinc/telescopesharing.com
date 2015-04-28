class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :name
  has_many :telescopes
  has_many :messages
  belongs_to :message

  validates_uniqueness_of :name
  validates_uniqueness_of :email

  attr_accessor :invite_code
  validate :invite_code_valid, on: :create

  def invite_code_valid
    unless self.invite_code == ENV["INVITE_CODE"]
      self.errors.add(:invite_code, "invalid.")
    end
  end

  def remember_me
    true
  end

  def observations
    a = Observation.in(telescope: telescope_ids).pluck(:id) # as operator
    b = Reservation.where(user: self).pluck(:observation_id) # as user
    Observation.in(id: a + b)
  end

  def pending_reservations
    observation_ids = observations.upcomming.pluck(:id)
    Reservation.in(observation: observation_ids).where(aasm_state: "pending")
  end
end
