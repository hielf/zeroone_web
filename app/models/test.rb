def Account.binding(user, bank_code, card_no)
    merchant_private_key = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANMW2O9hxB3zByvs4Adn1yJnCA12mjengluzo5/2dRVCJMI7ozSRdcDm8oqNfRqK191/XBZC5guM7D0120zXS2mmkIGMcKFNfyQchHhZvMbH5bHRe5/EN5n4KOAoIBTDFGNEyi7ztHZ+ZhBFZYUhMNrwP8Wc7TX3KD3jUrlhY8ydAgMBAAECgYBuWhJcyppxIbzNDM9tb667MGu4RhmHIM34TKgslvZMf8ChvfWrJKQPjWycXC1bs9v30n38sUp8HVbfBQm5WQ/1nyHZM+A2M0Zy2ebAXdpt8k4j5H+6o6DY+u8S/TIRXSfR7ov7FFwGJZQnG1cBrN69rVlSkug+KtWbc+yRtALJ4QJBAPQvZQc40JxpBEMeK4h6ov7UAOIqo5H+KReQS4QQMhsJqVWhUgvQZ0hvfApWBmSek0ByHQsfbypzODcTnfqriOUCQQDdTYJ8b23a8o52frllkpmwXah07Uyo+V0QJdNOlNLu/NezPAJUruRYunnnKdlQUhdMC0I3NOAZdEoki+CwYhFZAkBbpmZO/Z4e9rOo1WwVf6Ip7zydps9Z/oFB3ODbIpEL4OZzw2beFEyPvXhbEMq5fWNbbvlDsXqx/ij9UxmaekOZAkEAmo0MCO0k8lidJ6H+xjHoxWPTRr2G4SctWB6igOmsmhzYYyMQmaV+cXzhr4/pZY+/F2txde6mZwBw2y8Y3vXOGQJBAIfGN425cnS+259Nlq50WgX8PbtKCimqUZIxFIqLjgbnFhfW+RzeiUc8I/EnOs3cgJ50ekf7Ren/ZAjYN28Boj8="
    service_type         = "sign_query"
    merchant_code        = "2060220355"
    interface_version    = "V3.0"
    input_charset        = "UTF-8"
    sign_type            = "RSA-S"
    sign                 = ""
    mobile               = "18018559077"
    bank_code            = "SPDB"
    card_type            = "0"
    card_no              = "6225220104709514"

    sign_str = "bank_code=" + bank_code + "&" +
               "card_no=" + card_no + "&" +
               "card_type=" + card_type + "&" +
               "input_charset=" + input_charset + "&" +
               "interface_version=" + interface_version + "&" +
               "merchant_code=" + merchant_code + "&" +
               "mobile=" + mobile + "&" +
               "service_type=" + service_type

    # pri = OpenSSL::PKey::RSA.new File.read '/Users/hielf/workspace/keys/key.pem'
    pri = OpenSSL::PKey::RSA.new File.read '/var/keys/key.pem'
    sign = pri.sign('md5', sign_str.force_encoding("utf-8"))
    signature = Base64.encode64(sign)
    signature = signature.delete("\n").delete("\r")

    uri = URI.parse("https://api.dinpay.com/gateway/api/express")
    res = Net::HTTP.post_form(uri, service_type: service_type, merchant_code: merchant_code,
          interface_version: interface_version, input_charset: input_charset,
          sign_type: sign_type, sign: URI::encode(signature), mobile: mobile, bank_code: bank_code,
          card_type: card_type, card_no: card_no)

    result = Nokogiri::XML(res.body)
    return ((status == "success") ? true : false)
  end
