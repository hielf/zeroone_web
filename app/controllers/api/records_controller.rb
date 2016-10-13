class Api::RecordsController < Api::BaseController
  skip_before_action :authenticate_user!, only: [:notify]

  def index
    @records = current_user.records
  end

  def search
    connection = ActiveRecord::Base.connection
    sql = "select id, product_id, total_prize, total_insured, policy_no, start_date, end_date, sell_date, bonus, commis from records where user_id = #{current_user.id} "
    c1 = ""
    c2 = ""
    c1 =  " AND product_id in (select id from products where name like '%#{params[:product_name]}%') " if params[:product_name]
    c2 =  " AND policy_no like '%#{params[:policy_no]}%' " if params[:policy_no]
    @records = connection.execute(sql + c1 + c2)
  end

  def period_bonus
    @records = current_user.records.where("sell_date between ? AND ?", params[:start_date], params[:end_date])
  end

  def notify
    Rails.logger.warn "notify #{Time.now}, sign: #{params[:sign]}, other #{params};"
    # params = {"sign"=>"k5h1TtKzE/he3u2OM3bqI8ZHueW0hYLOT3VjvjcR4bZMmVy+4B6UcvO+uaZxbwTbJ9ui30vMuvPMLePY2036RJEbTnIvETlIE0w0YDs7mRj8XaZSnzvfUvhHU8baPvs1URrPcKENsYmflCcsdPG/J6jsA7Yp/dcAqROkg96+GQ0=", "timestamp"=>"20161012034610010", "bizContent"=>"PXcdop/YlCrNX8ePQss0+XvFPk5z/ToxDBS96rHx+pEozbe2jDqQgnGPDIyHPNenWFlwbMPM8ZFgZfgqf5TRDFYOhxKJGmbre/RJ8el/Np3EGpHpI3NUYSwuYuW78cDLd7JWRHbeEB4AjGytICx2YGYy/fl3XADaerObEXpNQloJodBanbaBGr8XgKRh7HdVjUAVUIxL0pq2ZrM5XMZUIW0AAWJpKiV9JHE0p3zcgKQnYr+HmemidDbnQOKFQMaiVOh+/puSe+9xR05gSiMY4vWQaj+HeWbRXfmgge/IrevaqcDIPnhmLIgQsMgXI0oFdg3uLswIm7LUZwL3DVsSnpq6UzIUgxJTn0FvDdsB7TsGJ0Mx/ftlYBXxFF1UOTuwGTLyc8b6kqFlJRrdVLN75BVguIKg4TzR2wsQq/8qsPKcJ2/H2vGwef9EI37NO3l0pNXt7yTfA5eanE5aP8x90cKQJb1zET5EcQkkoPeuGu10XePuvW9E/C/iqOZMdoaJ", "signType"=>"RSA", "charset"=>"UTF-8", "format"=>:json, "serviceName"=>"promotePolicyNotify", "controller"=>"api/records", "action"=>"notify"}
    params_hash = params
    params_hash.delete("sign")
    params_hash.delete("action")
    params_hash.delete("controller")
    params_hash.delete("serviceName")
    # json = params.sort.to_h.to_json

    appKey = ENV['zhongan_appKey']

    # Load PUBLIC key
    private_key = OpenSSL::PKey::RSA.new(File.read(ENV['zhongan_private_key']))

    # We have received the following data
    message = params_hash["bizContent"]
    decrypt_message = decrypt_msg(private_key, message) rescue api_error(status: 401)

    json = JSON.parse decrypt_message

    s = json["bizContent"]
    d = [s].pack("H*")

    key = ENV['zhongan_key']
    dec = RC4.new(key)
    decrypted = dec.decrypt(d) rescue api_error(status: 401)

    contents = JSON.parse decrypted

    # Verify the message & its signature
    # if public_key.verify(OpenSSL::Digest::SHA256.new, signature, message)
    #     "VALID: Signed by pair private key"
    # else
    #     "NOT VALID: Data tampered or private-public key mismatch!"
    # end
    Rails.logger.warn "notify finished #{Time.now}, json: #{json};"
    Rails.logger.warn "notify finished #{Time.now}, decrypted: #{decrypted};"

    @record = Record.new(user_id: contents["extraInfo"]["user_id"],
                         product_id: contents["extraInfo"]["product_id"],
                         sell_date: Time.now.strftime("%F"),
                         qty: 1,
                         total_prize: json["premium"],
                         total_insured: json["sumInsured"],
                         start_date: json["effectiveDate"],
                         end_date: json["expiryDate"],
                         policy_no: json["policyNo"])
    @product = Product.find(contents["extraInfo"]["product_id"].to_i)
    @record.bonus = @product.bonus
    @record.commis = @product.ratio * json["premium"].to_f
    if @record.save
      @record.confirm
      render plain: "success"
    end
  end
end
