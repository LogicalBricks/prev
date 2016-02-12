module DepositosHelper
  def select_options_for_payable(payable)
    payable.map { |g| [g.to_s, g.id, { data: { monto: g.monto_a_reponer } }] }
  end
end
