require 'digest'

hex = Digest::SHA256.hexdigest('Hello')

puts hex.to_i(16)