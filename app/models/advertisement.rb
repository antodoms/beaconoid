class Advertisement < ApplicationRecord
  #include Mongoid::Document
  belongs_to :beacon
  belongs_to :category

  has_attached_file :image, styles: { medium: "500x300", thumb: "150x100>" }, default_url: "//s3-ap-southeast-2.amazonaws.com/beaconoid/default.jpg", :path => "#{Rails.env}/image/:id/:style/:filename", validate_media_type: false
  validates :image, attachment_presence: false

  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  do_not_validate_attachment_file_type :image

  validates_uniqueness_of :name, :scope => :beacon_id, :message => " and Beacon combination should be unique!"

  default_scope { order(created_at: :desc) }

  # method to search by advertisement name
  def self.filter_by_name(text)
    joins("INNER JOIN categories ON categories.id = advertisements.category_id").where("(LOWER(advertisements.name) like LOWER(?)) OR (LOWER(advertisements.description) like LOWER(?)) OR (LOWER(categories.name) like LOWER(?))", "%#{text}%", "%#{text}%", "%#{text}%")
  end


end

WillPaginate.per_page = 10
