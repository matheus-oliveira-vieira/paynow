class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { administrator_paynow:5, administrator_company: 10, employee: 15, client: 20 }
  belongs_to :company, optional: true
  validate :user_email
  before_save :set_up_role

  private

    def user_email
      domain = email.split('@').last.split('.').first
      if domain == 'hotmail' || domain == 'gmail'
        errors.add(:email, "Domínio inválido")
      end
    end

    def set_up_role
      domain = email.split('@').last.split('.').first
      if domain == 'paynow'
        self.role = 'administrator_paynow'
      else
        company = Company.where("name like ?", "%#{domain}%")
        if company.present?
          self.role = 'employee'
        else
          self.role = 'administrator_company'
        end
      end
    end
end
