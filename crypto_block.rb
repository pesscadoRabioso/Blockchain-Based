require 'digest'
require 'pp'

class Block
  attr_accessor :data, :hash, :nonce

  def initialize(data)
    @data = data 
    @nonce, @hash = compute_hash_with_POW
  end

  def compute_hash_with_POW (difficulty = '00') #difficulty = probability = 16^n where n = dificulty level 
    nonce = 0
    loop do 
      hash = Digest::SHA256.hexdigest("#{nonce}#{data}")
      if hash.start_with?(difficulty)
        return [nonce,hash]
      else
        nonce +=1
        puts "Searching, it isn't #{hash}, We tried #{nonce} times!"
      end
    end
  end
end

pp Block.new('Test!')