class User < ApplicationRecord
  before_save { email.downcase! }
  
  validates :name,
    presence: true,
    length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
    
  validates :password,
    presence: true,
    length: { minimum: 6 },
    format: {
      with: /[0-9]/,
      message: "数字を含む必要があります。"
    }
  validates  :password,
    format: {
      with: /[a-z]/,
      message: "小文字アルファベットを含む必要があります。"
    }
  validates  :password,
    format: {
      with: /[A-Z]/,
      message: "大文字アルファベットを含む必要があります。"
    }
  has_secure_password
end