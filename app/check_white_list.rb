class CheckWhiteList

  def initialize
    @wl = ConfigLoad.new.load_white_list
  end

  def host_present?(http_host, path, request_method)
    path_info = path.split('/')[1]
    host = http_host.split('.')
    domain = host[0]
    if @wl.has_key?(domain)
      case @wl.dig(domain).length
        when 1
          return check_one_rule?(domain, path_info, request_method)
        when 2
          return check_two_rules?(domain, path_info, request_method)
        else
          p "parse error"
          return false
      end
      return false
    end
  end

  def valid_path_info?(path_info, target)
    path_info == target
  end

  def valid_request_method?(request_method,wl_method)
    request_method == wl_method
  end

  def check_one_rule?(domain, path_info, request_method)
    @wl.dig(domain).map{ |element|
      if element.class == Hash
        return (valid_path_info?(path_info, @wl.dig(domain, 0, "target"))) &&
          valid_request_method?(request_method, @wl.dig(domain, 0, "method"))
      elsif String
        return valid_path_info?(path_info,element)
      end
    }
  end

  def check_two_rules?(domain, path_info, request_method)
    @wl.dig(domain).map{ |element|
      if element.class == Hash
        if valid_path_info?(path_info, @wl.dig(domain, 0, "target"))
          return @wl.dig(domain, 0, "method").include?(request_method)
        end
      elsif String
        valid_path_info?(path_info,element)
        return valid_path_info?(path_info,element)
      end
    }
  end

end
