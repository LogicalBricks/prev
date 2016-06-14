FactoryGirl.define do
  factory :prevision do
    periodo Date.today.year
    monto_remanente "9.99"
    monto_presupuestado "190"

    trait :con_apartado do
      transient do
        apartado_monto_maximo nil
      end

      after :build do |prevision, evaluator|
        opts = { prevision: prevision }
        opts.merge! monto_maximo: evaluator.apartado_monto_maximo if evaluator.apartado_monto_maximo
        prevision.apartados << build(:apartado, opts)
      end
    end

    trait :con_deposito do
      transient do
        monto_depositado nil
      end

      after :build do |prevision, evaluator|
        opts = { prevision: prevision }
        opts.merge! monto: evaluator.monto_depositado if evaluator.monto_depositado
        prevision.depositos << build(:deposito, opts)
      end
    end

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
