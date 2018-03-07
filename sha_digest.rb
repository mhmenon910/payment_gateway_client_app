class ShaDigest
  require 'digest'
  attr_accessor :parameters

  def initialize(params)
    @parameters = params
  end

  def create_sha_digest_of_parameters_and_append_to_hash
    @params_with_seprator = StringWithPipe.new(@parameters).build_string_with_pipe
    @parameters[:hash] = Digest::SHA1.hexdigest(@params_with_seprator)
    @parameters
  end

end
