FactoryGirl.define do
  factory :deposito do
    monto "9.99"
    fecha "2015-06-06"
    descripcion "MyText"
    prevision
  end

end

# == Schema Information
#
# Table name: depositos
#
#  id           :integer          not null, primary key
#  monto        :decimal(, )
#  fecha        :date
#  descripcion  :text
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
