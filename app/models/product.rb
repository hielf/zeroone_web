class Product < ActiveRecord::Base
  PRODUCT_STATUS = ["待审核", "已审核"]
  PRODUCT_ALL_STATUS = ["已审核", "作废"]

  has_many :records, dependent: :destroy

  mount_uploader :image, QrcodeUploader

  state_machine :status, :initial => :'待审核' do
    event :disable do
      transition [:'待审核', :'已审核'] => :'作废'
    end
    event :confirm do
      transition :'待审核' => :'已审核'
    end
    event :deny do
      transition :'已审核' => :'待审核'
    end
  end
end
