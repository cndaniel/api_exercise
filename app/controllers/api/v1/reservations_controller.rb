class Api::V1::ReservationsController < ApiController
  before_action :set_up_reservation, only: [:show, :update]
  before_action :authenticate_user!, only: [:index]

  def index
    @reservations = current_user.reservations
  end

  def create
    @train = Train.find_by_number!(params[:train_number])
    @reservation = Reservation.new(train_id: @train.id,
                                   seat_number: params[:seat_number],
                                   customer_name: params[:customer_name],
                                   customer_phone: params[:customer_phone])
    @reservation.user = current_user
    if @reservation.save
      render json: { booking_code: @reservation.booking_code,
                     reservation_url: api_v1_reservation_url(@reservation.booking_code) }
    else
      render json: { message: ' reservation failure', error: @reservation.errors }, stauts: 400
    end
  end

  def show; end

  def update
    @reservation.update(customer_name: params[:customer_name],
                        customer_phone: params[:customer_phone])

    render json: { message: '更新成功' }
  end

  private

  def set_up_reservation
    @reservation = Reservation.find_by_booking_code!(params[:booking_code])
  end
end
