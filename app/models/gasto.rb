class Gasto < ActiveRecord::Base
  attr_accessor :forzar_monto

  # == Associations ==
  belongs_to :socio
  belongs_to :proveedor
  belongs_to :apartado

  # == Validations ==
  validates :socio, :apartado, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validate :fecha_dentro_de_vigencia_de_prevision
  validate :monto_no_mayor_a_monto_maximo_de_apartado
  validate :monto_no_mayor_a_monto_socio

  def supera_monto_socio?
    socio and socio.monto and monto > socio.monto
  end

private

  def fecha_dentro_de_vigencia_de_prevision
    errors.add :fecha, 'debe ser posterior al inicio de la prevision' if apartado and fecha < apartado.fecha_inicial
    errors.add :fecha, 'debe ser anterior al final de la prevision' if apartado and fecha > apartado.fecha_final
  end

  def monto_no_mayor_a_monto_maximo_de_apartado
    errors.add :monto, 'no puede ser mayor al monto del apartado' if apartado and monto > apartado.monto_maximo
  end

  def monto_no_mayor_a_monto_socio
    errors.add :monto, 'supera el monto del socio' if supera_monto_socio? and !forzar_monto?
  end

  def forzar_monto?
    ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include? forzar_monto
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
