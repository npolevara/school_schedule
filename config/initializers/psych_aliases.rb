require 'yaml'
module Psych
  class << self
    alias_method :old_load, :load

    def load(*args, **kwargs)
      kwargs[:aliases] = true
      old_load(*args, **kwargs)
    end
  end
end
