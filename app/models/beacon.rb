class Beacon < ApplicationRecord
  #include Mongoid::Document

  validates_uniqueness_of :name, :unique_reference

  belongs_to :store
  has_many :advertisements

  #field :name, type: String

  def self.filter_by_name(text)
    joins("INNER JOIN stores ON stores.id = beacons.store_id").where("(LOWER(stores.name) like LOWER(?)) OR (LOWER(beacons.name) like LOWER(?))", "%#{text}%", "%#{text}%")
  end

end
