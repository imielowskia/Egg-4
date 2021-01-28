class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:indeks]
  validates :indeks,uniqueness: true
  has_many :egzams
  has_many :questions, through: :egzams

  def self.import(file)

    CSV.foreach(file.path, headers: true) do |row|
      @u = User.new
      @u.attributes = row.to_hash
      @u.encrypted_password = ::BCrypt::Password.create(@u.encrypted_password)
      #@u.password = @u.encrypted_password
      @u.save(validate: false)
    end
  end

end
