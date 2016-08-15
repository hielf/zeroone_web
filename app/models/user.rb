class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || I18n.t("not_email")) unless
      value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end

class User < ActiveRecord::Base
  has_secure_password
  # validates :openid, presence: true, uniqueness: true
  # validates :number, length: { is: 6 } # validation is called before before_create ...
  validates :cell, length: { minimum: 11 }, allow_blank: true
  validates :email, presence: true, email: true, allow_blank: true

  has_many :records, dependent: :destroy

  before_create :generate_number
  after_create :generate_qrcode

  mount_uploader :avatar, AvatarUploader
  mount_uploader :qrcode, QrcodeUploader
  # CHANNELS = ["001", "002", "003", "004", "005", "006"]
  #
  # def total_commission
  #   commission + second_commission + third_commission
  # end
  #
  # def total_amount
  #   leaders.sum(:amount)
  # end

  private
    def generate_number
      self.number = loop do
        random_number = rand(100000..999999).to_s
        break random_number unless self.class.exists?(number: random_number)
      end
    end

    def generate_qrcode
      qr = RQRCode::QRCode.new("#{self.number}")
      update(qrcode: open(qr.as_png.save("tmp/cache/#{self.number}.png")))
    end
end
