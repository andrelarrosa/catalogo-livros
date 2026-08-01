class Author < ApplicationRecord
    has_many :books, dependent: :restrict_with_error
    
    validates :name, presence: true, length: { minimum: 3 }

    validates :birth_year,
              numericality: { only_integer: true, less_than_or_equal_to: Date.current.year },
              allow_blank: true
end