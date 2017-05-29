class Beacon < ActiveRecord::Base
  #include Mongoid::Document

  validates_uniqueness_of :name

  belongs_to :store
  has_many :advertisements

  #field :name, type: String

  def self.filter_by_beacon_name(text)
	where(name: text)
  end
  
  def self.filter_by_reference(text)
  	where(unique_reference: text)
  end

  def self.filter_by_store_id(text)
  	where(store_id: text.to_s)
  end

  def self.filter_by_status(text)
  	where(current_status: text)
  end

end
