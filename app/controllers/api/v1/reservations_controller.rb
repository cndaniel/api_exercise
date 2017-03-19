class Api::V1::ReservationsController < ApiController
  before_action :set_up_reservation, only: [:show, :update]

  def create
    @train = Train.find_by_number!( params[:train_number])
    @reservation = Reservation.new( train_id: @train.id,
    seat_number: params[:seat_number],
    customer_name: params[:customer_name],
    customer_phone: params[:customer_phone]
    )

    if @reservation.save
      render json:{ booking_code: @reservation.booking_code,
        reservation_url: api_v1_reservation_url(@reservation.booking_code)
      }
    else
      render json:{ message:" reservation failure", error: @reservation.errors, status: 400}
    end
  end

  def show
    render json:{
      booking_code: @reservation.booking_code,
      train_number: @reservation.train.number,
      seat_number: @reservation.seat_number,
      customer_name: @reservation.customer_name,
      customer_phone: @reservation.customer_phone
    }
  end

  def update
    @reservation.update( customer_name: params[:customer_name],
    customer_phone: params[:customer_phone] )

    render json:{ message: "更新成功",  status: 200}
  end

  private
  def set_up_reservation
    @reservation = Reservation.find_by_booking_code!( params[:booking_code])
  end
end
