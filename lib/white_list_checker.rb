class WhiteListChecker

  def initialize
    @wl = ConfigLoad.load_white_list
  end

  def host_present?(http_host, path, request_method)
    path_info = path.split('/')[1]
    host = http_host.split('.')
    domain = host[0]
    check_rule?(domain, path_info, request_method) if @wl.has_key?(domain)
  end

  def valid_path_info?(path_info, target)
    path_info == target
  end

  def valid_request_method?(request_method,wl_method)
    request_method == wl_method
  end

  def check_rule?(domain, path_info, request_method)
    @wl.dig(domain).map{ |element|
      if element.is_a?(Hash)
        case @wl.dig(domain).length
        when 1
          rule_one?(domain, path_info, request_method)
        when 2
          rule_two?(domain, path_info, request_method)
        else
          raise 'Parse error'
        end
      elsif element.is_a?(String)
        valid_path_info?(path_info,element)
      else
        raise 'Parse error'
      end
    }
  end

  def rule_one?(domain, path_info, request_method)
    (valid_path_info?(path_info, wl_target(domain))) &&
      valid_request_method?(request_method, wl_method(domain))
  end

  def rule_two?(domain, path_info, request_method)
    if valid_path_info?(path_info, wl_target(domain))
      wl_method(domain).include?(request_method)
    end
  end

  def wl_target(domain)
    @wl.dig(domain, 0, 'target')
  end

  def wl_method(domain)
    @wl.dig(domain, 0, 'method')
  end
end
