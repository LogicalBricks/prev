FactoryGirl.define do
  factory :tope do
    monto "19.99"
    prevision
    socio
  end

end

# == Schema Information
#
# Table name: topes
#
#  id           :integer          not null, primary key
#  socio        :string
#  monto        :decimal(, )
#  prevision_id :integer
#  socio_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
