require 'hashids'

module HashidsSupport
  module ClassMethods
    def hashids
      Hashids.new("BestTime App Site", 5, "abcdefghijklmnopABCDEFGHIJKLMNOP")
    end

    def encrypt_id(id)
      hashids.encrypt(id)
    end

    def decrypt_id(id)
      hashids.decrypt(id).first
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def encrypted_id
    self.class.encrypt_id(id)
  end

  def to_param
    encrypted_id
  end
end

module ActiveRecord
  module FinderMethods
    alias_method :orig_find_one, :find_one
    def find_one(id)
      if id.is_a?(String)
        orig_find_one decrypt_id(id)
      else
        orig_find_one(id)
      end
    end
  end
end

ActiveRecord::Base.send :include, HashidsSupport