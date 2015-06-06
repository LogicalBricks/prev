FactoryGirl.define do
  factory :proveedor do
    nombre "MyString"
rfc "MyString"
  end

end

# == Schema Information
#
# Table name: proveedores
#
#  id         :integer          not null, primary key
#  nombre     :string
#  rfc        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
