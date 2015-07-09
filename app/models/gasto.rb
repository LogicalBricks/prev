class Gasto < ActiveRecord::Base
  # == Enums ==
  enum metodo_pago: [:transferencia, :tarjeta, :reposicion]

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
  validate :monto_no_supera_monto_maximo_de_apartado
  validate :monto_no_supera_monto_depositado

  # == Scopes ==
  scope :de_prevision, -> prevision { joins(:apartado).where(apartados: { prevision_id: prevision } ) }
  scope :de_socio,     -> socio { joins(:socio).where(socio_id: socio) }
  scope :para_listado, -> { includes(:socio, apartado: [:rubro, :prevision]) }

  # == Methods ==

  def supera_monto_socio?
    socio and socio.monto and monto.to_f + socio.monto_gastado > socio.monto
  end

  def prevision
    apartado.prevision if apartado
  end

private

  def fecha_dentro_de_vigencia_de_prevision
    errors.add :fecha, 'debe estar en el rango de fechas de la previsión' if prevision and !prevision.fecha_valida?(fecha)
  end

  def monto_no_supera_monto_maximo_de_apartado
    errors.add :monto, :greater_than_monto_apartado if supera_monto_apartado?
  end

  def supera_monto_apartado?
    apartado and monto.to_f + monto_gastado_en_apartado > apartado.monto_maximo
  end

  def monto_gastado_en_apartado
    socio.monto_gastado(apartado)
  end

  def monto_no_supera_monto_depositado
    errors.add :monto, :greater_than_monto_depositado if supera_monto_depositado?
  end

  def supera_monto_depositado?
    socio and prevision and monto.to_f + prevision.monto_gastado > prevision.monto_depositado
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
