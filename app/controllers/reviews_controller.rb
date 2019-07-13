class ReviewsController < ApplicationController
    before_action :require_login

    def create
        @product = Product.find(params[:product_id])
        @review = Review.new(review_params)
        @review.product = @product
        @review.user = current_user
        
        if @review.save
            redirect_to @product
        else
            render @product
        end
    end

    def destroy
        @product = Product.find(params[:product_id])
        @review = @product.reviews.find(params[:id])
        @review.destroy

        redirect_to @product
    end

    private

    def review_params
        params.require(:review).permit(:rating, :description, :user_id, :product_id)
    end

    def require_login
        unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_login_url # halts request cycle
        end
    end
end
