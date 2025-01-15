# This class is just an abstract class version an active record

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
