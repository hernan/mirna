# frozen_string_literal: true

class Admin::CustomersController < Admin::BaseController
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to admin_customers_path, notice: "Customer created"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path, notice: "Customer updated"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    Customer.find(params[:id])
            .destroy
    redirect_to admin_customers_path, notice: "Customer destroyed"
  end

  def toggle_active
    customer = Customer.find(params[:id])
    customer.toggle!(:active)

    redirect_to admin_customers_path, notice: "Customer updated"
  end

  private
    def customer_params
      params.require(:customer)
            .permit(
              :name,
              :email,
              :phone,
              :host,
              :active
            )
    end
end
