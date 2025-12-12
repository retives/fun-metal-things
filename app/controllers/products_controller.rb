# app/controllers/products_controller.rb

class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.page(params[:page])
    authorize Product 
  end

  def show
    authorize @product 
  end

  def new
    @product = Product.new
    authorize @product 
  end

  # Admin
  def create
    @product = Product.new(product_params)
    authorize @product 
    if @product.save
      redirect_to @product, notice: 'Товар успішно додано.'
    else
      render :new
    end
  end

  def edit
    authorize @product 
  end


end