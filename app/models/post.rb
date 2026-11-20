class Post < ApplicationRecord
  belongs_to :user

  validates :content,
            presence: true,
            length: { maximum: 1_000 }
end
