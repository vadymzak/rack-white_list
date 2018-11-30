class WhiteListChecker

  def initialize(http_host, path, request_method)
    @wl = ConfigLoad.load_white_list
    @path_info = path.split('/')[1]
    @request_method = request_method
    @domain = http_host.split('.')[0]
  end

  def host_present?
    check_rule? if @wl.has_key?(@domain)
    return @result
  end

  def check_rule?
    @wl.dig(@domain).map(&parse_element)
  end

  def parse_element
    ->(element) { (is_hash?(element) || is_string?(element)) unless @result }
  end

  def is_hash?(element)
    hash_element if element.is_a?(Hash)
  end

  def is_string?(element)
    @result = valid_path_info?(element) if element.is_a?(String)
  end

  def hash_element
    hash_lenght? ? rule_one? : rule_two?
  end

  def hash_lenght?
    @wl.dig(@domain).length == 1 ? true : false
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
