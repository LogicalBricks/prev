FactoryGirl.define do
  factory :tope do
    socio "MyString"
    monto "9.99"
    prevision nil
    socio nil
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
