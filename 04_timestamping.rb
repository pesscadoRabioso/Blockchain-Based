require 'pp'
require 'digest'

#pp Time.at(Time.now.to_i)

class Block
  attr_reader :data, 
  :prev, 
  :difficulty,
  :time,
  :nonce # number used once - or lucky (mining) lottery number
  
  #def hash 
    #Digest::SHA256.hexdigest( "#{nonce}#{time}#{difficulty}#{prev}#{data}" )
  #end

  def initialize (data, prev, difficulty = "0000")
    @data = data
    @prev = prev
    @difficulty = difficulty
    @nonce, @time = compute_hash_with_POW ( difficulty ) 
  end

  def compute_hash_with_POW ( difficulty = '00' )
    nonce = 0
    time = Time.now.to_i #time for better ((unbreakable))
    loop do 
      hash = Digest::SHA256.hexdigest( "#{nonce}#{time}#{difficulty}#{prev}#{data}" )
      if hash.start_with? ( difficulty )
        return [nonce,time]
      else
        nonce += 1
      end
    end #loop
  end #compute_hash func
end #block class

b0 = Block.new('Hello0!', '00000000000000000000000000000000' )
b1 = Block.new('Hello1!', b0.hash )
b2 = Block.new('Hello2!', b1.hash )
b3 = Block.new('Hello3!', b2.hash )

pp hashes = [b0,b1,b2,b3]