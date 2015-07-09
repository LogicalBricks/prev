FactoryGirl.define do
  factory :rubro do
    nombre "MyString"
    descripcion "MyText"
  end

end

# == Schema Information
#
# Table name: rubros
#
#  id          :integer          not null, primary key
#  nombre      :string
#  descripcion :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
