module Api
  module V1
    class OrdersController < ApplicationController
      before_action :order_params, only: [:create]

      def index
        if not params[:customer_id].present?
          @orders = Order.all
        else
          @orders = Order.where(customer_id: params[:customer_id])
        end
        render json: @orders
      end
      def show
        # @orders = Order.where(customer_id: params[:customer_id])
        @order = Order.find(params[:order_id])
        render json: @order
      end
      def create
        # puts "hello???@op"
        # puts params.inspect
        # @customer_id = request.headers["customer_id"]
        @customer_id = params[:customer_id]
        # puts "@customer_id #{@customer_id}"
        @order = Order.new(status: "pending", customer_id: @customer_id)

        if @order.save
          render json: @order
        else
          render json: { message: "Unable to create order" }, status: :unprocessable_entity
        end        
      end

      def ship
        @order = Order.find(params[:id])
        @order.update(status: :shipped)
        render json: @order
      end

      private

      def order_params
        params.require(:customer_id)
        params.permit(:customer_id)
      end      
    end
  end
end