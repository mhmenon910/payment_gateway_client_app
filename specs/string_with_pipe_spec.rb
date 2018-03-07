require './string_with_pipe.rb'
describe StringWithPipe do
  describe '#convert_params_to_string_with_pipe' do
    it 'should change params to string with pipe' do
      hash = {bank_ifsc_code: 'ICIC0000001',amount:'100000'}
      hash_obj = StringWithPipe.new(hash)
      expect(hash_obj.build_string_with_pipe).to eq ('bank_ifsc_code=ICIC0000001|amount=100000')
    end
  end

  describe '#convert_string_with_pipe_to_hash' do
    it 'should change params from string with pipe to hash' do
      string = "bank_ifsc_code=ICIC0000001|amount=100000"
      string_obj = StringWithPipe.new(string)
      expect(string_obj.remove_pipe_and_build_hash).to eq ({"bank_ifsc_code"=> 'ICIC0000001',"amount"=>'100000'})
    end
  end
end
