# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :rol do
    nombre "MyString"
  end

end
