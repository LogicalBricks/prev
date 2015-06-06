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

FactoryGirl.define do
  factory :socio do
    nombre "MyString"
usuario nil
  end

end
