#! /usr/bin/ruby

require 'socket'
require 'uri'

s = TCPServer.new ENV['PORT'].to_i
while c = s.accept
  l = c.readline
  p l
  if l =~ /GET \/ /
    c.puts "HTTP/1.0 200 OK\r\n\r\n"
  elsif l =~ /GET \/add\/(\d+)\/(\d+) /
    c.puts "HTTP/1.0 200 OK\r\n\r\n#{$1.to_i + $2.to_i}"
  elsif l =~ /GET \/mult\/(\d+)\/(\d+) /
    c.puts "HTTP/1.0 200 OK\r\n\r\n#{$1.to_i * $2.to_i}"
  elsif l =~ /GET \/cowsay\/(.+?) /
    # Security issue
    c.puts "HTTP/1.0 200 OK\r\n\r\n#{`cowsay "#{URI.decode_uri_component $1}"`}"
  elsif l =~ /GET \/uuid /
    u = `uuidgen -t`.chomp
    c.puts "HTTP/1.0 200 OK\r\nContent-Length: #{u.size}\r\n\r\n#{u}\r\n"
  else
    c.puts "HTTP/1.0 400 Bad"
  end

  c.close
end

