class WhiteListChecker

  def initialize
    @wl = ConfigLoad.load_white_list
  end

  def host_present?(http_host, path, request_method)
    @path_info = path.split('/')[1]
    @request_method = request_method
    @domain = http_host.split('.')[0]
    check_rule? if @wl.has_key?(@domain)
    return @result
  end

  def check_rule?
    @wl.dig(@domain).map(&parse_element)
  end

  def parse_element
    ->(element) { (is_hash?(element) || is_string?(element)) unless @result }
  end

  def parse_error?
    raise 'Parse error'
    false
  end

  def is_hash?(element)
    hash_element if element.is_a?(Hash)
  end

  def is_string?(element)
    @result = valid_path_info?(element) if element.is_a?(String)
  end

  def hash_element
    case @wl.dig(@domain).length
    when 1
      rule_one?
    when 2
      rule_two?
    else
      raise 'Parse error'
    end
  end

  def rule_one?
   @result = ((valid_path_info?(wl_target)) && valid_request_method?)
  end

  def rule_two?
      valid_path_info?(wl_target) unless rule_one?
  end

  def wl_target
    @wl.dig(@domain, 0, 'target')
  end

  def wl_method
    @wl.dig(@domain, 0, 'method')
  end

  def valid_path_info?(target)
    @path_info == target
  end

  def valid_request_method?
    wl_method.include?(@request_method)
  end

end
