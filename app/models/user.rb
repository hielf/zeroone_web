class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || I18n.t("not_email")) unless
      value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end

class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_token
  before_create :generate_number

  validates :cell, length: { minimum: 11 },presence: true, uniqueness: true
  # validates :email, presence: true, email: true, allow_blank: true

  belongs_to :superior, class_name: 'User'
  has_many :subordinates, class_name: 'User', foreign_key: "superior_id"
  has_many :records, dependent: :destroy

  before_create :generate_number
  after_create :generate_qrcode

  mount_uploader :avatar, AvatarUploader
  mount_uploader :qrcode, QrcodeUploader

  def User.send_code(cell, code)

    # the cell must exist and more than 11 digits
    return false unless cell && cell.to_s.length >= 11

    msg         = code.to_s
    @var        = {}
    @var["code"] = msg
    uri         = URI.parse("https://api.submail.cn/message/xsend.json")
    username    = Rails.application.secrets.sms_appid
    password    = Rails.application.secrets.sms_signature
    project     = Rails.application.secrets.sms_project
    res         = Net::HTTP.post_form(uri, appid: username, to: cell, project: project, signature: password, vars: @var.to_json)

    status      = JSON.parse(res.body)["status"]
    return ((status == "success") ? true : false)
  end

  def reset_token
    reset_auth_token!
  end


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

    def generate_token
      loop do
        self.token = SecureRandom.base64(64)
        break if !User.find_by(token: token)
      end
    end

    def reset_auth_token!
      generate_token
      save
    end
end
