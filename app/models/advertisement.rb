class Advertisement < ActiveRecord::Base
  #include Mongoid::Document
  belongs_to :beacon
  belongs_to :category

  #has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "//s3-ap-southeast-2.amazonaws.com/beaconoid/default.jpg"

  # has_attached_file :image,
  #                   :storage => :s3,
  #                   :s3_region => ENV["AWS_REGION"],
  #                   :s3_host_name => ENV["S3_HOSTNAME"],
  #                   :path => "#{Rails.env}/image/:id/:filename",
  #                   default_url: "//s3-ap-southeast-2.amazonaws.com/beaconoid/default.jpg",
  #                   :s3_credentials => Proc.new{|a| a.instance.s3_credentials }


  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  def s3_credentials
    {:bucket => "beaconoid", :access_key_id => ENV["ACCESS_KEY_ID"], :secret_access_key => ENV["SECRET_ACCESS_KEY"]}
  end
 #Read more at https://www.pluralsight.com/guides/ruby-ruby-on-rails/handling-file-upload-using-ruby-on-rails-5-api#LlGBKswCkMp7h73l.99
end
