# == Schema Information
#
# Table name: apartados
#
#  id           :integer          not null, primary key
#  monto_maximo :decimal(, )
#  rubro_id     :integer
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :apartado do
    monto_maximo "9.99"
rubro nil
prevision nil
  end

end
