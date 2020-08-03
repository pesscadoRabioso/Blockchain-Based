require 'digest'
require 'pp'

class Block 
    attr_reader :data, :prev, :hash, :nonce

    def initialize(data, prev)
        @data = data
        @prev = prev
        @nonce, @hash = compute_hash_with_POW
    end

    def compute_hash_with_POW(difficulty = '0000')
        nonce = 0
        loop do 
            hash = Digest::SHA256.hexdigest("#{nonce}#{prev}#{data}")
            if hash.start_with?( difficulty )
                return [nonce,hash]
            else
                nonce += 1
            end
        end 
    end
end

b0 = Block.new( 'Hello, Cryptos!', '0000000000000000000000000000000000000000000000000000000000000000')
b1 = Block.new( 'Hello, Cryptos! - Hello, Cryptos!', b0.hash)
b2 = Block.new( 'Your Name Here', b1.hash)
b3 = Block.new( 'Data Data Data Data', b2.hash)

blockchain = [b0,b1,b2,b3]

#pp blockchain

# example breaking the blockchain

def sha256(data)
    Digest::SHA256.hexdigest(data)
end

b0.hash == sha256("#{b0.nonce}#{b0.prev}#{b0.data}")
b1.hash == sha256("#{b1.nonce}#{b1.prev}#{b1.data}") 
b2.hash == sha256("#{b2.nonce}#{b2.prev}#{b2.data}") 
b3.hash == sha256("#{b3.nonce}#{b3.prev}#{b3.data}")

b1 = Block.new('Hello, Koruptus! - Hello, Koruptus!', b0.hash)

pp b0.prev == '0000000000000000000000000000000000000000000000000000000000000000'
pp b1.prev == b0.hash 
pp b2.prev == b1.hash 
pp b3.prev == b2.hash 




