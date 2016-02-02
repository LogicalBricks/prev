FactoryGirl.define do
  factory :socio do
    nombre "MyString"
    usuario

    trait :con_tope do
      transient do
        monto_tope nil
        prevision nil
      end

      after :build do |socio, evaluator|
        opts = { socio: socio }
        opts.merge! monto: evaluator.monto_tope if evaluator.monto_tope
        opts.merge! prevision: evaluator.prevision if evaluator.prevision
        socio.tope = build(:tope, opts)
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
