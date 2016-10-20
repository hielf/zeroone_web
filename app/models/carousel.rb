class Carousel < ActiveRecord::Base
  mount_uploader :first, QrcodeUploader
  mount_uploader :second, QrcodeUploader
  mount_uploader :third, QrcodeUploader
end
