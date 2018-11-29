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
          return (valid_path_info?(path_info, @wl.dig(domain, 0, 'target'))) &&
            valid_request_method?(request_method, @wl.dig(domain, 0, 'method'))
        when 2
          if valid_path_info?(path_info, @wl.dig(domain, 0, 'target'))
            return @wl.dig(domain, 0, 'method').include?(request_method)
          end
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

end
