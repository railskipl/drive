class BlogsController < ApplicationController
  before_filter :authenticate_user!
	def search_blog
		@blogs =  Blog.all
        @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
        @carprofile = current_user.carprofiles
        @blog_comments = BlogComment.all
      if  params[:name]
       @blog = Blog.find_by_name(params[:name])
      end
      @user_blogs = @blog.user_blogs.paginate(page: params[:page], per_page: 5) 
      @user_blogs = @user_blogs.order("created_at desc")
   end
end
