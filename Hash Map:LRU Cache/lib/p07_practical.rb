require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash_map = Hash.new(0)
  string.chars.each do |chr|
    hash_map[chr] += 1
  end
  hash_map.values.count {|val| val <= 1} <= 1
end
