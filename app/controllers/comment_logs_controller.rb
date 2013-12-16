class CommentLogsController < ApplicationController
   before_filter :authenticate_user!, :except => []
  
   def index
    @comment_logbooks = CommentLogbook.find(:all, :order => "created_at DESC")
  	@blog_comments = BlogComment.find(:all, :order => "created_at DESC")
  	@spotlighted_cars = Carprofile.where("spotlighted = ?",true)
   end
end
