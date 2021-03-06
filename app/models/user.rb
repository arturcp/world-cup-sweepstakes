class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :tournaments, dependent: :destroy
  has_many :user_guesses, dependent: :destroy
  has_many :ranking_logs

  APPROVED_DOMAINS = ['youse.com.br', 'helloyouser.com.br']

  validates :email, presence: true, if: :domain_check

  def domain_check
    unless APPROVED_DOMAINS.any? { |word| email.end_with?(word)}
      errors.add(:email, "não é de um domínio válido")
    end
  end

  def tournament_admin?(tournament)
    id.eql?(tournament.user_id)
  end
end
