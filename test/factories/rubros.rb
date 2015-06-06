FactoryGirl.define do
  factory :rubro do
    nombre "MyString"
descripcion "MyText"
agrupador nil
  end

end

# == Schema Information
#
# Table name: rubros
#
#  id           :integer          not null, primary key
#  nombre       :string
#  descripcion  :text
#  agrupador_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_rubros_on_agrupador_id  (agrupador_id)
#
# Foreign Keys
#
#  fk_rails_bdc357dada  (agrupador_id => agrupadores.id)
#
