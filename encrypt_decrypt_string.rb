class EncryptDecryptString
  # https://gurudathbn.wordpress.com/2015/02/04/aes-cipher-encryption-decryption-algorithms-using-ruby-on-rails/
  require 'openssl'
  require 'base64'
  KEY = 'Q9fbkBF8au24C9wshGRW9ut8ecYpyXye5vhFLtHFdGjRg3a4HxPYRfQaKutZx5N4'

  attr_accessor :parameters

  def initialize(params)
    @parameters = params
  end

  def encryption
   cipher = OpenSSL::Cipher::AES.new(128, :CBC)
   cipher.encrypt()
   cipher.key = KEY
   crypt = cipher.update(@parameters) + cipher.final()
   crypt_string = (Base64.encode64(crypt))
   return crypt_string
  end

  def decryption
    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.decrypt()
    cipher.key = KEY
    tempkey = Base64.decode64(@parameters)
    crypt = cipher.update(tempkey)
    crypt << cipher.final()
    return crypt
 end

end
#p result = EncryptDecryptString.new("manoj").encryption
#p result =EncryptDecryptString.new("l0zdUqPzcX/dbuq5v4w+EIFK4SY9aflNE/AOdlAjB/2d2D/s0tyvi5/9/L56\nP659K4pw3182d7s05CSCKUL4Fi/VeRAUK/sbRl84sQyPzaomSuG63Mjk4PZO\nsSpYGz7mUNb/KeQfYTyZECA5kpUso1sbkVgmahEgZB5L9RgLsBCLgDQ7pfYI\nUek4JNX2Zj2+Fiuj+wzILURUajnvr+ADFaujMYnC/FfKuwW7A2MW/lJKNWgG\nNc5bJNl66iKaqrDhosfZz9TRtHsaE5BK6fCFQfKj2xGq14L56/cdkgIf5jQ=\n").decryption
