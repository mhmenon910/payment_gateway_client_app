require './encrypt_decrypt_string.rb'
describe EncryptDecryptString do
  describe '#encrypt/decrypt the string' do
    it 'should encrypt decrypt the string' do
      string = "bank_ifsc_code: 'ICIC0000001'|,amount:'100000'"
      encrypted_string = EncryptDecryptString.new(string).encryption
      decrypted_string = EncryptDecryptString.new(encrypted_string).decryption
      expect(decrypted_string).to eq ("bank_ifsc_code: 'ICIC0000001'|,amount:'100000'")
    end
  end
end
