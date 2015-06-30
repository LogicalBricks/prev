FactoryGirl.define do
  factory :comision do
    monto "9.99"
    descripcion "MyString"
    fecha "2015-06-29"
    prevision
  end

end

# == Schema Information
#
# Table name: comisiones
#
#  id           :integer          not null, primary key
#  monto        :decimal(, )
#  descripcion  :string
#  fecha        :date
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
