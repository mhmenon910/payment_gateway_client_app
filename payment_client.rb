require './sha_digest.rb'
require './encrypt_decrypt_string.rb'
require './string_with_pipe.rb'

class PaymentClient
  require 'net/http'
  require 'uri'
  require 'json'

  URL = "http://localhost:3000/transaction"

  attr_accessor :parameters

  def initialize(params)
    @parameters = params
  end

  def send_request_to_server
    @parameters = ShaDigest.new(@parameters).create_sha_digest_of_parameters_and_append_to_hash
    @payload_with_hash = StringWithPipe.new(@parameters).build_string_with_pipe
    @payload_to_pg = EncryptDecryptString.new(@payload_with_hash).encryption
    server_message = {}
    server_message[:msg] = @payload_to_pg
    uri = URI(URL)
    response = Net::HTTP.post_form(uri, server_message)
    response_string_from_server = EncryptDecryptString.new(JSON.parse(response.body)["payload_to_client"]).decryption
    hsh = StringWithPipe.new(response_string_from_server).remove_pipe_and_build_hash
    return hsh, JSON.parse(response.body)["txn_status"], JSON.parse(response.body)["payment_gateway_transaction_reference"]
  end

end

# client_running part, server is running in localhost:3000, please refer server application
client_params = {
                  "bank_ifsc_code"=>"ICIC0000001",
                  "bank_account_number"=>"11111111",
                  "amount"=>"10000.00",
                  "merchant_transaction_ref"=>"txn001",
                  "transaction_date"=>"2014-11-14",
                  "payment_gateway_merchant_reference"=>"merc001"
               }

server_result_params , txn_status, payment_gateway_transaction_reference = PaymentClient.new(client_params).send_request_to_server
server_result_params = server_result_params.tap{|x| x.delete("hash")}
client_params = client_params.tap{|x| x.delete(:hash)}


if client_params == server_result_params
  p "parameters are matching from both client and server"
  p "txn_status : #{txn_status}"
  p "payment_gateway_transaction_reference : #{payment_gateway_transaction_reference}"
  server_result_params.each do |key, value|
    p "#{key}:" "#{value}"
  end
end
