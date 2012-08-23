class ArticlesController < ApplicationController

  before_filter :user_area, :only => [:new, :create]
  before_filter :admin_area, :only => [:verify, :destroy]
  after_filter :update_last_visit!, :only => [:index]

  def index
    @articles = Article.verified.page(params[:page])

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def unverified
    @articles = Article.unverified.page(params[:page])
  end

  def tagged
    @articles = Tag.where(:name => params[:tag]).first.articles.page(params[:page])
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(params[:article])

    if @article.save
      redirect_to unverified_path, notice: 'Article was successfully submited.'
    else
      render action: "new"
    end
  end

  def verify
    article = Article.find(params[:id])
    article.verify!

    flash[:notice] = "Article verified."

    redirect_to :back
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash[:notice] = "Article deleted."

    redirect_to :back
  end

  private

  def update_last_visit!
    cookies[:last_visit] = @articles.first.id if @articles.first
  end
end
