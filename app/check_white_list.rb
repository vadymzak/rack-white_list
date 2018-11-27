class CheckWhiteList

  def initialize
    @wl = LoadConfig.new.load_white_list
  end

  def host_present?(http_host)
    host = http_host.split('.')
    p @wl.has_key?(host[0])
    if @wl.has_key?(host[0])
      # case path = wl[host[0]]
      #   when request_path
      #     return true
      #   when check_target(path)
      #     return true
      #   else
      #     return false
      # end
      true
    end
  end

  def check_target(mas)
    true
    #mas['target']
  end
end
