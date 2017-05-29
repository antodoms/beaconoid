class Advertisement < ActiveRecord::Base
  #include Mongoid::Document
  belongs_to :beacon
  belongs_to :category

  has_attached_file :image, styles: { medium: "500x300", thumb: "150x100>" }, default_url: "//s3-ap-southeast-2.amazonaws.com/beaconoid/default.jpg", :path => "#{Rails.env}/image/:id/:style/:filename"
  validates :image, attachment_presence: false


  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def self.filter_by_advertisement_name(text)
  	where(name: text)
  end

  def self.filter_by_beacon_id(text)
  	where(beacon_id: text)
  end

  def self.filter_by_category_id(text)
  	where(category_id: text)
  end



end
