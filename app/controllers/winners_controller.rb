# frozen_string_literal: true

class WinnersController < ApplicationController
  def index
    cash_outs = CashOut.select(:name, :tickets).all.to_a
    named_tickets = cash_outs.each_with_object([]) do |cash_out, names|
      cash_out.tickets.times { names << cash_out.name }
    end
    @winner_1 = named_tickets.sample
    named_tickets.delete(@winner_1)
    @winner_2 = named_tickets.sample
    named_tickets.delete(@winner_2)
    @winner_3 = named_tickets.sample
  end
end
