class Api::RecordsController < Api::BaseController
  skip_before_action :authenticate_user!, only: [:notify]
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
    decrypt_message = decrypt_msg(private_key, message)

    json = JSON.parse decrypt_message

    s = json["bizContent"]
    d = [s].pack("H*")

    key = ENV['zhongan_key']
    dec = RC4.new(key)
    decrypted = dec.decrypt(d)

    JSON.parse decrypted

    # Verify the message & its signature
    # if public_key.verify(OpenSSL::Digest::SHA256.new, signature, message)
    #     "VALID: Signed by pair private key"
    # else
    #     "NOT VALID: Data tampered or private-public key mismatch!"
    # end
    Rails.logger.warn "notify finished #{Time.now}, decrypted: #{decrypted};"
    render json: {result: "ok"}, status: 201
  end
end
