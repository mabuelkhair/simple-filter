class ProductsController < ApplicationController
    def index
        if params[:code]
            promotion = Promotion.find_by_code(params[:code])
            @products = promotion ? promotion.products : Product.none
        else
            @products = Product.all
        end
        @products = @products.where("name like ?", "%#{params[:search]}%") if params[:search]
        @products = @products.where( department_id: params[:department_ids]) if params[:department_ids]
        pagenated_products = @products.page params[:page]
        render json: pagenated_products
    end
end
