class PointsController < ApplicationController

  def create
    if current_user
      @article = Article.find(params[:article_id])

      point = @article.points.build
      point.user = current_user
      point.save
    end

    render :nothing => true, :layout => false
  end

end