require 'rc4'

class Product < ActiveRecord::Base
  PRODUCT_STATUS = ["待审核", "已审核"]
  PRODUCT_ALL_STATUS = ["已审核", "作废"]

  has_many :records, dependent: :destroy

  mount_uploader :image, QrcodeUploader

  state_machine :status, :initial => :'待审核' do
    event :disable do
      transition [:'待审核', :'已审核'] => :'作废'
    end
    event :confirm do
      transition :'待审核' => :'已审核'
    end
    event :deny do
      transition :'已审核' => :'待审核'
    end
  end

  def promoturl(user)
    payChannel           = "wxpay"
    returnUrl            = ENV['return_url']
    json                 = ""
    json                 = "{\"extraInfo\":{\"user_id\":#{user.id}, \"product_id\":11}}" if user
    # json                 = {extraInfo:{user_id: user.id}}
    # json                 = JSON::generate(data)

    key = ENV['zhongan_key']
    enc = RC4.new(key)
    encrypted = enc.encrypt(json)
    bizContent = encrypted.unpack('H*')[0]

    self.url + "&" + "payChannel=" + payChannel + "&" + "returnUrl=" + returnUrl + "&" + "bizContent=" + bizContent
  end

  # def Product.notify(user, bank_code, card_no)
  #
  #     key = "open20160501"
  #     enc = RC4.new(key)
  #     encrypted = enc.encrypt(data)
  #
  #     sign_str = "bank_code=" + bank_code + "&" +
  #                "card_no=" + card_no + "&" +
  #                "card_type=" + card_type + "&" +
  #                "input_charset=" + input_charset + "&" +
  #                "interface_version=" + interface_version + "&" +
  #                "merchant_code=" + merchant_code + "&" +
  #                "mobile=" + mobile + "&" +
  #                "service_type=" + service_type
  #
  #     # pri = OpenSSL::PKey::RSA.new File.read '/Users/hielf/workspace/keys/key.pem'
  #     pri = OpenSSL::PKey::RSA.new File.read '/var/keys/key.pem'
  #     sign = pri.sign('md5', sign_str.force_encoding("utf-8"))
  #     signature = Base64.encode64(sign)
  #     signature = signature.delete("\n").delete("\r")
  #
  #     uri = URI.parse("https://api.dinpay.com/gateway/api/express")
  #     res = Net::HTTP.post_form(uri, service_type: service_type, merchant_code: merchant_code,
  #           interface_version: interface_version, input_charset: input_charset,
  #           sign_type: sign_type, sign: URI::encode(signature), mobile: mobile, bank_code: bank_code,
  #           card_type: card_type, card_no: card_no)
  #
  #     result = Nokogiri::XML(res.body)
  #     return ((status == "success") ? true : false)
  #   end

end
