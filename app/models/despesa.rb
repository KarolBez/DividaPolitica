class Despesa < ApplicationRecord
  belongs_to :deputado

  validates :ide_documento, uniqueness: true, presence: true
end
