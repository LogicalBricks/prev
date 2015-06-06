# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rol < ActiveRecord::Base
  # == Associations ==
  has_and_belongs_to_many :usuarios
end
