FactoryGirl.define do
  factory :socio do
    nombre "MyString"
usuario nil
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
# Indexes
#
#  index_socios_on_usuario_id  (usuario_id)
#
# Foreign Keys
#
#  fk_rails_0b8e8596bb  (usuario_id => usuarios.id)
#
