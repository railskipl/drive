class FavouritesController < ApplicationController
     before_filter :authenticate_user!

  def index
  
  	@favourites = current_user.favourites.order("created_at desc").paginate(page: params[:page], per_page: 10) 
   #raise  current_user.favourites.count.inspect
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)

  end

  def user_logbook
  	
  	@logbook = Logbook.find(params[:id])
    unless current_user.id == @logbook.user_id
  	  @favourite = Favourite.find_or_create_by_user_id_and_logbook_id(:user_id => current_user.id, :favourite_type => "favourite_logbook", :favourite_type_id => @logbook.id, :logbook_id => @logbook.id )
    end
    #@favourite.save
  	redirect_to logbook_path(@logbook)
  end

  def user_blog
   @user_blog = UserBlog.find(params[:id])
    unless current_user.id == @user_blog.user_id
      @favourite = Favourite.find_or_create_by_user_id_and_user_blog_id(:user_id => current_user.id, :favourite_type => "favourite_blog", :favourite_type_id => @user_blog.id, :user_blog_id => @user_blog.id)
    end
   #@favourite.save
   redirect_to user_blog_path(@user_blog)
  end	

  def mycarprofile
    
   @carprofile = Carprofile.find(params[:id])
    unless current_user.id == @carprofile.user_id
     @favourite = Favourite.find_or_create_by_user_id_and_carprofile_id(:user_id => current_user.id, :favourite_type => "favourite_carprofile", :favourite_type_id => @carprofile.id, :carprofile_id => @carprofile.id)
    end
   #@favourite.save
   redirect_to carprofile_path(@carprofile)
  end 

  def deletefav
    
    if params[:n_id]
       @favourite = Favourite.find_by_id(params[:n_id])
    end
      @favourite.destroy
      flash[:notice] = "you have done unfavourite"
      redirect_to favourites_path
    
  end
end
