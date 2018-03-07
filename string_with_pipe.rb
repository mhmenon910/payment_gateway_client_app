class StringWithPipe
  def initialize(params)
    @parameters = params
  end

  def build_string_with_pipe
    return if @parameters.values.any?{|i| i.empty?}
    seprator_string = []
    @parameters.each do |key, value|
      seprator_string << "#{key}=#{value}"
    end
    seprator_string.join("|")
  end

  def remove_pipe_and_build_hash
    array = @parameters.split(/\|/)
    hash = {}
    array.each do |text|
      key, value = text.split(/\=/)
      hash[key] = value
    end
    return hash
  end
end
