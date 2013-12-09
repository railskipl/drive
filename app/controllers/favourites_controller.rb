class FavouritesController < ApplicationController
  def index
  	#@user_blog = UserBlog.find(params[:id])
  	@favourites = current_user.favourites
    
  end

  def user_logbook
  	
  	@logbook = Logbook.find(params[:id])
  	@favourite = Favourite.new(:user_id => current_user.id, :favourite_type => "favourite_logbook", :favourite_type_id => @logbook.id, :logbook_id => @logbook.id )
  	@favourite.save
  	redirect_to logbook_path(@logbook)
  end

  def user_blog
   @user_blog = UserBlog.find(params[:id])
   @favourite = Favourite.new(:user_id => current_user.id, :favourite_type => "favourite_blog", :favourite_type_id => @user_blog.id, :user_blog_id => @user_blog.id)
   @favourite.save
   redirect_to user_blog_path(@user_blog)
  end	

  def destroy

    @favourite = Favourite.find(params[:id])

      @favourite.destroy
      flash[:notice] = "you have done unfavourite"
      redirect_to favourites_path
    
  end
end
