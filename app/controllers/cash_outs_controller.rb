class CashOutsController < ApplicationController
  helper_method :params

  def index
    @cash_outs = CashOut
                   .all
                   .select('*, 100 * CAST(tickets AS decimal) / SUM(tickets) OVER() AS odds')
                   .order(tickets: :desc)
    @winners_found = @cash_outs.any?(&:winner?)
  end

  def new
    @cash_out = CashOut.new
  end

  def show
    @cash_out = CashOut.find(params[:id])
    render :new
  end

  def update
    @cash_out = CashOut.find(params[:id])
    @cash_out.assign_attributes(params.require(:cash_out).permit(*%i[name cash shifts]))
    @cash_out.tickets = (@cash_out.cash + @cash_out.shifts * 350) / 10

    if @cash_out.valid?
      @cash_out.save!
      flash[:alert] = "Congratulations #{@cash_out.name} you have #{@cash_out.tickets} tickets"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end

  def create
    @cash_out = CashOut.new(params.require(:cash_out).permit(*%i[name cash shifts]))
    @cash_out.tickets = (@cash_out.cash + @cash_out.shifts * 350) / 10

    if @cash_out.valid?
      @cash_out.save!
      flash[:alert] = "Congratulations #{@cash_out.name} you have #{@cash_out.tickets} tickets"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @cash_out = CashOut.find(params[:id])
    @cash_out.destroy
    flash[:alert] = "Deleted #{@cash_out.name}'s entry"
    redirect_to root_path, status: :see_other
  end
end
