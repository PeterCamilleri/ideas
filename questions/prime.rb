# Is this number a prime?

module PrimeChecker

  @prime_cache = [2,3]

  def self.prime?(n)
    search_limit = Math.sqrt(n).to_i + 1
    last_cache = @prime_cache[-1]

    while last_cache < search_limit do
      last_cache += 2
      @prime_cache << last_cache if PrimeChecker.prime?(last_cache)
    end

    @prime_cache.each do |pn|
      return true if pn > search_limit
      return false if (n % pn) == 0
    end

    true
  end

end

# Sample run
#
# 31 mysh>%=PrimeChecker.prime?(1_000_000_000_000)
# false
# Elapsed execution time = 1.592 seconds.
#

