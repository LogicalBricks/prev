FactoryGirl.define do
  factory :socio do
    nombre "MyString"
    usuario

    trait :con_tope do
      after :build do |socio|
        socio.tope = build :tope, socio: socio
      end
    end

    trait :con_usuario do
      after :build do |socio|
        socio.usuario = build :usuario
      end
    end
  end
end

# == Schema Information
#
# Table name: socios
#
#  id         :integer          not null, primary key
#  nombre     :string
#  usuario_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
