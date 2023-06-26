class Student < ApplicationRecord
    belongs_to :instructor
    validates :name,presence: true
    validates :age, numericality: {greater_than_or_equal: 15}
end
