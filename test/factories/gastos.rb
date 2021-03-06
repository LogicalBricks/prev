FactoryGirl.define do
  factory :gasto do
    factura_xml "MyString"
    factura_pdf "MyString"
    solicitud "MyString"
    monto "9.99"
    fecha Date.today
    metodo_pago 1
    descripcion "MyText"
    proveedor nil
    apartado
    socio { build :socio, :con_tope, monto_tope: 50, prevision: apartado.prevision }
  end

end

# == Schema Information
#
# Table name: gastos
#
#  id           :integer          not null, primary key
#  factura_xml  :string
#  factura_pdf  :string
#  solicitud    :string
#  monto        :decimal(, )
#  fecha        :date
#  metodo_pago  :integer          default(0)
#  descripcion  :text
#  socio_id     :integer
#  proveedor_id :integer
#  apartado_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
