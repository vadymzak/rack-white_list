class WhiteListChecker
  def initialize(http_host, path, request_method)
    @wl = ConfigLoad.load_white_list
    @path_info = path.split('/')[1]
    @request_method = request_method
    @domain = http_host.split('.')[0]
  end

  def host_present?
    check_rule? if @wl.has_key?(@domain)
    @result
  end

  def check_rule?
    @wl.dig(@domain).map(&parse_element)
  end

  def parse_element
    ->(element) do
      p host_data.values
      unless @result
        if element.is_a?(Hash)
          hash_element(element)
        elsif element.is_a?(String)
          @result = valid_path_info?(element)
        end
      end
    end
  end

  def hash_element(element)
    # case @wl.dig(@domain).length
    # when 1
    #   rule_one?
    # when 2
    #   rule_two?
    # end
  #  p (element[0].keys & host_data.keys)
  end

  def rule_one?
    @result = (valid_path_info?(wl_target) && valid_request_method?)
  end

  def rule_two?
    valid_path_info?(wl_target) unless rule_one?
  end

  def valid_path_info?(target)
    @path_info == target
  end

  def valid_request_method?
    wl_method.include?(@request_method)
  end

  def host_data
    {'target': @path_info, 'methods': @request_method}
  end

  def wl_target
    @wl.dig(@domain, 0, 'target')
  end

  def wl_method
    @wl.dig(@domain, 0, 'method')
  end

end
