#! /usr/bin/ruby

require 'socket'

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
    c.puts "HTTP/1.0 200 OK\r\n\r\n#{$1}"
  elsif l =~ /GET \/uuid /
    c.puts "HTTP/1.0 200 OK\r\n\r\n0d1472f5-f65a-48a6-a754-14028e3475c0"
  else
    c.puts "HTTP/1.0 400 Bad"
  end

  c.close
end
