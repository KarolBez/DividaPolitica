class Deputado < ApplicationRecord
  has_many :despesas, dependent: :destroy

  validates :ide_cadastro, uniqueness: true
end
