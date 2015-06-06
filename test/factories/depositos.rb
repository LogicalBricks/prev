FactoryGirl.define do
  factory :deposito do
    monto "9.99"
fecha "2015-06-06"
descripcion "MyText"
prevision nil
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
# Indexes
#
#  index_depositos_on_prevision_id  (prevision_id)
#
# Foreign Keys
#
#  fk_rails_3728a922f6  (prevision_id => previsiones.id)
#
