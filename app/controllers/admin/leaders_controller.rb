class Admin::LeadersController < Admin::BaseController
  def index
    @leaders = Leader.page params[:page]
  end

  def edit
    @leader = Leader.find(params[:id])
  end

  def export
    @leaders = Leader.all
    respond_to do |format|
      header_string = 'attachment; filename=leaders' + DateTime.now.to_s(:number) + ".xlsx"
      format.xlsx{  response.headers['Content-Disposition'] = header_string}
    end
  end

  def confirm
    Leader.find(params[:id]).confirm
    redirect_to admin_leaders_path
  end

  def deny
    Leader.find(params[:id]).deny
    redirect_to admin_leaders_path
  end

  def update
    @leader = Leader.find(params[:id])
    if @leader.update(leader_params)
      # user commission
      user = @leader.user
      if user
        user_record = user.records.create(
          amount: @leader.commission,
          from_amount: user.balance,
          to_amount: user.balance,
          date: Date.today,
          desc: "一级佣金",
          )
        user.update(balance: (user.balance + user_record.amount))
        user.update(commission: (user.commission + user_record.amount))
        user_record.update(to_amount: user.balance)

        # superior commission
        superior = user.superior
        if superior
          superior_record = superior.records.create(
            amount: @leader.second_commission,
            from_amount: superior.balance,
            to_amount: superior.balance,
            date: Date.today,
            desc: "二级佣金",
            )
          superior.update(balance: (superior.balance + superior_record.amount))
          superior.update(second_commission: (superior.second_commission + superior_record.amount))
          superior_record.update(to_amount: superior.balance)

          # higher superior
          higher_superior = superior.superior
          if higher_superior
            higher_superior_record = higher_superior.records.create(
              amount: @leader.third_commission,
              from_amount: higher_superior.balance,
              to_amount: higher_superior.balance,
              date: Date.today,
              desc: "三级佣金",
              )
            higher_superior.update(balance: (higher_superior.balance + higher_superior_record.amount))
            higher_superior.update(third_commission: (higher_superior.third_commission + higher_superior_record.amount))
            higher_superior_record.update(to_amount: higher_superior.balance)
          end
        end
      end
      redirect_to admin_leaders_path
    else
      render 'edit'
    end
  end

  private
    def leader_params
      params.require(:leader).permit(
        :approve_time, :amount, :commission,
        :second_commission, :third_commission,
        :loan_state)
    end
end