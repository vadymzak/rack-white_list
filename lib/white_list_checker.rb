class WhiteListChecker
  def initialize(http_host, path, request_method)
    @wl = ConfigLoad.load_white_list
    @path_info = path.split('/')[1]
    @request_method = request_method
    @domain = http_host.split('.')[0]
  end

  def host_present?
    check_rule? if @wl.key?(@domain)
    @result
  end

  def check_rule?
    @wl.dig(@domain).map(&parse_element)
  end

  def parse_element
    ->(element) do
      break if @result

      if element.is_a?(Hash)
        @result = hash_element(element)
      elsif element.is_a?(String)
        @result = valid_path_info?(element)
      end
    end
  end

  def hash_element(element)
    case @wl.dig(@domain).length
    when 1
      host_data.values == element.values
    when 2
      (element.fetch('target') == host_data.fetch(:target)) &&
        element.fetch('method').include?(host_data.fetch(:method))
    end
  end

  def valid_path_info?(target)
    @path_info == target
  end

  def host_data
    { 'target': @path_info, 'method': @request_method }
  end
end
