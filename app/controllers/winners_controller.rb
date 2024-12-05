# frozen_string_literal: true

class WinnersController < ApplicationController
  def index
    find_winners
  end

  private

  def find_winners
    cash_outs = CashOut.all.to_a
    named_tickets = cash_outs.each_with_object([]) do |cash_out, names|
      cash_out.tickets.times { names << cash_out.id }
    end
    @winner_1_id = named_tickets.sample
    named_tickets.delete(@winner_1_id)
    @winner_2_id = named_tickets.sample
    named_tickets.delete(@winner_2_id)
    @winner_3_id = named_tickets.sample

    @winner_1 = cash_outs.detect { _1.id == @winner_1_id }
    @winner_2 = cash_outs.detect { _1.id == @winner_2_id }
    @winner_3 = cash_outs.detect { _1.id == @winner_3_id }
  end
end
