class HomeController < ApplicationController

  before_filter :user_area, :only => [:profile]

  def about
  end

  def profile
  end

end