class Record < ActiveRecord::Base
  RECORD_STATUS = ["待审核", "已审核"]

  belongs_to :user
  belongs_to :product

  state_machine :status, :initial => :'待审核' do
    event :confirm do
      transition :'待审核' => :'已审核'
    end
    event :deny do
      transition :'已审核' => :'待审核'
    end
  end
end
