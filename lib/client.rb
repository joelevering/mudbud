require 'net/telnet'

class Client
  localhost = Net::Telnet::new("Host" => "localhost",
                               "Port" => 2000,
                               "Timeout" => 10,
                               "Prompt" => /[$%#>] \z/n,
                               "Telnetmode" => true) { |str| print str }

  localhost.waitfor(/./) do |str|
    print str
  end
end
