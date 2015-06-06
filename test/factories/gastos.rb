FactoryGirl.define do
  factory :gasto do
    factura_xml "MyString"
factura_pdf "MyString"
solicitud "MyString"
monto "9.99"
fecha "2015-06-06"
metodo_pago 1
descripcion "MyText"
socio nil
proveedor nil
apartado nil
  end

end
