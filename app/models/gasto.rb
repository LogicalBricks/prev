class Gasto < ActiveRecord::Base
  # == Enums ==
  enum metodo_pago: [:transferencia, :tarjeta, :efectivo, :otro]

  mount_uploader :factura_xml, FacturaXmlUploader
  mount_uploader :factura_pdf, FacturaPdfUploader
  mount_uploader :solicitud, SolicitudUploader

  # == Associations ==
  belongs_to :socio
  belongs_to :proveedor
  belongs_to :apartado

  # == Validations ==
  validates :socio, :apartado, :fecha, :monto, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validates :forzar_monto, acceptance: true, presence: true, if: :supera_monto_socio?
  validate :fecha_dentro_de_vigencia_de_prevision
  validate :monto_no_mayor_a_monto_maximo_de_apartado

  # == Methods ==

  def supera_monto_socio?
    socio and socio.monto and monto.to_f + socio.gastos.sum(:monto) > socio.monto
  end

private

  def fecha_dentro_de_vigencia_de_prevision
    errors.add :fecha, 'debe ser posterior al inicio de la prevision' if apartado and fecha < apartado.fecha_inicial
    errors.add :fecha, 'debe ser anterior al final de la prevision' if apartado and fecha > apartado.fecha_final
  end

  def monto_no_mayor_a_monto_maximo_de_apartado
    errors.add :monto, 'no puede ser mayor al monto del apartado' if supera_monto_apartado?
  end

  def supera_monto_apartado?
    apartado and monto.to_f + monto_consumido > apartado.monto_maximo
  end

  def monto_consumido
    socio.gastos.where(apartado: apartado).sum(:monto)
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
