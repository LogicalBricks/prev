FactoryGirl.define do
  factory :usuario do
    sequence(:email) { |n| "usuario_#{ n }@mail.com" }
    password 'abcd1234'
    password_confirmation 'abcd1234'
  end

end

# == Schema Information
#
# Table name: usuarios
#
#  id                     :integer          not null, primary key
#  rol                    :integer          default(0)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
