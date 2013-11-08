class PagesController < ApplicationController
	def show
		@page = Page.find(params[:id])
		
		@meta_title = @page.meta_title
		@meta_description = @page.meta_description
		@meta_keyword = @page.meta_keyword
	end
end
