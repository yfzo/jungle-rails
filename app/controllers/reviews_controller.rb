class ReviewsController < ApplicationController

    def create
        @product = Product.find_by(id: params[:product_id])
        @review = Review.new(review_params)
        @review.product = @product
        @review.user = current_user
        
        if @review.save
            redirect_to @product
        else
            render @product
        end
    end

    private

    def review_params
        params.require(:review).permit(:rating, :description, :user_id, :product_id)
    end
end
