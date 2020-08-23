require 'digest'

def compute_hash_with_POW ( data, difficulty = '00' ) 
	nonce = 0
	loop do 
		hash = Digest::SHA256.hexdigest("#{nonce}#{data}")
		if hash.start_with?( difficulty)
			return [nonce,hash]
		else
			nonce += 1 
		end
	end
end


(1..7).each do |factor|
	difficulty = '0' * factor
	puts "difficulty: #{difficulty} (#{difficulty.length*4} bits.)"

	puts "Starting search..."
	t1 = Time.now
	nonce, hash = compute_hash_with_POW("Hello!", difficulty)
	t2 = Time.now

	delta = t2 - t1
	puts "Elapsed Time: %.4f seconds, Hashes Calculated: %d" % [delta,nonce]

	if delta > 0
		hashrate = Float( nonce / delta )
		puts "Hash Rate: %d hashes per second" % hashrate
	end
	puts
end
