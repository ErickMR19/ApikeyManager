class ApiKey < ApplicationRecord
  validates :email, presence: { message: "Debe indicar el correo electronico" }
  validates :email, uniqueness: { case_sensitive: false, message: "Error, ese correo ya fue registrado" }
  before_save :generate_hash
  
  def generate_hash
    self.api_key = Digest::MD5.hexdigest self.email
  end
  
  def self.valid_key?(key)
    exists?(api_key: key)
  end
  
  def self.increment_num_requests(key)
    current = find_by api_key: key
    current.num_requests += 1
    current.save
  end
end
