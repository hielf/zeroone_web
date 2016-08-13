class WelcomeController < ApplicationController
  skip_before_action :logged_in_admin
  def index
  end
end
