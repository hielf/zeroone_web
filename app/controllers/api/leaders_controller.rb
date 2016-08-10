class Api::LeadersController < Api::BaseController
  def create
    leader = current_user.leaders.new(
      name:                   params[:name],
      phone:                  params[:phone],
      sex:                    params[:sex],
      workplace:              params[:workplace],
      birth:                  params[:birth],
      income:                 params[:income],
      payoff_type:            params[:payoffType],
      job:                    params[:profession],
      has_credit_card:        params[:hasCreditCard],
      loan_experience:        params[:loanExperience],
      mortgage:               params[:mortgage],
      has_car_loan:           params[:hasCarLoan],
      has_accumulation_fund:  params[:hasAccumulationFund],
      has_life_insurance:     params[:hasLifeInsurance],
      channel:                params[:channel],
      apply_date:             params[:applyDate]
      )
    if leader.save
      render nothing: true, status: 201
    else
      return api_error(status: 422)
    end
  end

  def index
    @leaders = Leader.ransack(user_id_eq: current_user.id, phone_end: params["phone"]).result
  end
end