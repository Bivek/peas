require 'socket'

# General Peas-specific code for working with Switchboard
module Peas
  class Switchboard
    def initialize
      @socket = connection
      @socket
    end

    def self.connection
      client = TCPSocket.new Peas.host, Peas::SWITCHBOARD_PORT
      ssl_client = OpenSSL::SSL::SSLSocket.new client
      ssl_client.sync_close = true # Close both tcp and ssl socket at the same time
      ssl_client.connect
      ssl_client
    end

    def self.wait_for_connection
      Timeout.timeout(5) do
        loop do
          begin
            s = connection
            s.close
            break
          rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
            sleep 0.1
          end
        end
      end
    rescue Timeout::Error
      raise "Couldn't connect to the Peas Switchboard " \
        "at #{Peas.host}:#{Peas::SWITCHBOARD_PORT}"
    end
  end
end
