class RecordsController < BaseController
  before_action :logged_in?
  def index
    if current_user.nil?
      @records = Record.all
    else
      @records = Record.where('user_id in (?)', current_user.subordinates.map {|u| u.id})
    end
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id
    if @record.save
      redirect_to records_url
    else
      render 'new'
    end
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      redirect_to records_url
    else
      render 'edit'
    end
  end

  def destroy
    Record.find(params[:id]).destroy
    redirect_to records_url
  end

  def confirm
    Record.find(params[:id]).confirm
    redirect_to records_url
  end

  def deny
    Record.find(params[:id]).deny
    redirect_to records_url
  end

  private
    def record_params
      params.require(:record).permit(:user_id, :product_id, :sell_date, :qty, :total_prize,
                                     :customer_name, :customer_cell, :status)
    end
end
