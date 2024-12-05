class CashOutsController < ApplicationController
  def index
    @cash_outs = CashOut.all.order(tickets: :desc)
  end

  def new
    @cash_out = CashOut.new
  end

  def create
    @cash_out = CashOut.new(params.require(:cash_out).permit(*%i[name cash shifts]))
    @cash_out.tickets = (@cash_out.cash + @cash_out.shifts * 200) / 10

    if @cash_out.valid?
      @cash_out.save!
      flash[:alert] = "Congratulations #{@cash_out.name} you have #{@cash_out.tickets}"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end
end
