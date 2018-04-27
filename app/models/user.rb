class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :tournaments, dependent: :destroy
  has_many :user_guesses, dependent: :destroy
  has_many :ranking_logs

  APPROVED_DOMAINS = ['youse.com.br', 'youse.co']

  validates :email, presence: true, if: :domain_check

  def domain_check
    unless APPROVED_DOMAINS.any? { |word| email.end_with?(word)}
      errors.add(:email, "is not from a valid domain")
    end
  end

  def tournament_admin?(tournament)
    id.eql?(tournament.user_id)
  end
end
