class Book < ApplicationRecord

  belongs_to :user

  has_one_attached :book_image

end
