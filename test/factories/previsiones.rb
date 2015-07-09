FactoryGirl.define do
  factory :prevision do
    periodo "2015"
    monto_remanente "9.99"
    monto_presupuestado "190"
  end

end

# == Schema Information
#
# Table name: previsiones
#
#  id                  :integer          not null, primary key
#  fecha_inicial       :date
#  fecha_final         :date
#  monto               :decimal(, )
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  monto_remanente     :decimal(, )
#  monto_presupuestado :decimal(, )
#
