require 'action_view'
include ActionView::Helpers::NumberHelper

class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_user!, only: :wx_get_jsapi_ticket
  def get_info
    @user = current_user
  end

  def get_qrcode
    @qrcode_url = current_user.qrcode_url
  end

  def get_invite_code
    @invite_code = current_user.number
  end

  def get_balance
    render json: {balance: current_user.balance}
  end

  def index
    @subordinates = User.ransack(superior_id_eq: current_user.id, cell_end: params[:phone]).result
    if current_user.subordinates.blank?
      @lower_subordinate = []
    else
      @lower_subordinate = User.ransack(superior_id_in: current_user.subordinates.ids, cell_end: params[:phone]).result
    end

    users = []
    @subordinates.each do |user|
      users << {:name => filter_name(user.name),
                :cell => filter_phone(user.cell),
                :level => "二级",
                :leaders_count => user.leaders.count,
                :leaders_amount => number_with_delimiter(user.leaders.sum(:amount).to_i),
                :commission => number_with_delimiter(user.leaders.sum(:second_commission).to_i)}
    end

    @lower_subordinate.each do |user|
      users << {:name => filter_name(user.name),
                :cell => filter_phone(user.cell),
                :level => "三级",
                :leaders_count => user.leaders.count,
                :leaders_amount => number_with_delimiter(user.leaders.sum(:amount).to_i),
                :commission => number_with_delimiter(user.leaders.sum(:third_commission).to_i)}
    end
    render json: {users: users}
  end

  def set_superior
    return render json: { message: "请不要重复绑定"}, status: 422  if current_user.superior
    @superior = User.find_by(number: params["invite_code"])
    return render json: { message: "无效邀请码"}, status: 422 if params["invite_code"].blank? || @superior.nil?
    return render json: { message: "不允许绑定自己" }, status: 422 if @superior.id == current_user.id
    if current_user.update(superior_id: @superior.id)
      record = current_user.records.create(
        amount: 400,
        from_amount: current_user.balance,
        to_amount: current_user.balance,
        date: Date.today,
        desc: "新手红包",
        )
      current_user.update(balance: (current_user.balance + 400) )
      record.update(to_amount: current_user.balance)
      render json: {message: "绑定成功"}, status: 200
    else
      render json: {message: "绑定失败"}, status: 422
    end
  end

  def update_profile
    @user = current_user
    @user.avatar = parse_image_data(params[:user][:avatar]) if params[:user] && params[:user][:avatar]
    if @user.update(user_params)
      render 'get_info'
    else
      return api_error(status: 422)
    end
  end

  def commissions
    render json: {
      commission: current_user.commission,
      second_commission: current_user.second_commission,
      third_commission: current_user.third_commission,
      total_commission: current_user.total_commission,
      leader_count: current_user.leaders.count,
      today_leader_count: current_user.leaders.where("created_at >= ?", Time.zone.now.beginning_of_day).count,
      total_amount: current_user.leaders.sum(:amount)

    }
  end

  def subordinates
    subordinate_amount = 0
    lower_subordinate_count = 0
    current_user.subordinates.each do |user|
      subordinate_amount += user.leaders.sum(:amount)
      lower_subordinate_count += user.subordinates.count
    end
    render json: {
      subordinate_count: current_user.subordinates.count,
      lower_subordinate_count: lower_subordinate_count,
      subordinate_amount: subordinate_amount,
      commission: current_user.commission,
      second_commission: current_user.second_commission,
      third_commission: current_user.third_commission
    }
  end

  def wx_get_jsapi_ticket
    jsapi_ticket = ""
    if Ticket.first && !Ticket.first.ticket.nil? && Ticket.first.expires_at > Time.current
      jsapi_ticket = Ticket.first.ticket
    else
      uri = URI("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{ENV["WECHAT_APP_ID"]}&secret=#{ENV["WECHAT_APP_SECRET"]}")
      res = Net::HTTP.get_response(uri)
      json =  JSON.parse(res.body.gsub(/[\u0000-\u001f]+/, ''))
      access_token = json["access_token"]

      ticket_uri = URI("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=#{access_token}&type=jsapi")
      ticket_res = Net::HTTP.get_response(ticket_uri)
      ticket_json = JSON.parse(ticket_res.body.gsub(/[\u0000-\u001f]+/, ''))
      jsapi_ticket = ticket_json["ticket"]
      Ticket.delete_all
      Ticket.create(
        ticket: jsapi_ticket,
        token: access_token,
        expires_at: Time.current + 1.hours
        )
    end

    if jsapi_ticket == ""
      render json: {message: "error"}
    else
      timestamp = Time.now.to_i
      wxnonceStr = "zeroone_web"
      wxOri = Digest::SHA1.hexdigest("jsapi_ticket=#{jsapi_ticket}&noncestr=#{wxnonceStr}&timestamp=#{timestamp}&url=#{params[:url]}")
      render json: {timestamp: timestamp, noncestr: wxnonceStr, signature: wxOri, appid: ENV["WECHAT_APP_ID"]}
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :name, :cell, :email, :id_card, :bank_card, :alipay)
    end
end
