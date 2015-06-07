FactoryGirl.define do
  factory :prevision do
    fecha_inicial "2015-06-06"
    fecha_final "2016-06-06"
    monto "199.99"
  end

end

# == Schema Information
#
# Table name: previsiones
#
#  id            :integer          not null, primary key
#  fecha_inicial :date
#  fecha_final   :date
#  monto         :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
