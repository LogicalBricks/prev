class Gasto < ActiveRecord::Base
  # == Attrs ==
  attr_accessor :descontar_de_reservado
  attr_writer :validador_monto_reservado, :monto_reservado_updater

  # == Enums ==
  enum metodo_pago: [:transferencia, :tarjeta, :reembolso]

  mount_uploader :factura_xml, FacturaXmlUploader
  mount_uploader :factura_pdf, FacturaPdfUploader
  mount_uploader :solicitud, SolicitudUploader

  # == Associations ==
  belongs_to :socio
  belongs_to :proveedor
  belongs_to :apartado
  belongs_to :deposito, inverse_of: :gastos

  # == Validations ==
  validates :socio, :apartado, :fecha, :monto, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validate :fecha_dentro_de_vigencia_de_prevision
  validate :monto_no_supera_monto_maximo_de_apartado
  validate :monto_no_supera_monto_depositado
  validate :monto_no_supera_monto_disponible
  validate :monto_reservado_valido?, if: :descontar_de_reservado?

  # == Callbacks ==
  before_save :actualizar_monto_reservado, if: :descontar_de_reservado?

  # == Scopes ==
  scope :de_prevision,                 -> prevision { joins(:apartado).merge Apartado.de_prevision(prevision) }
  scope :de_prevision_activa,          -> { de_prevision(Prevision.default) }
  scope :de_socio,                     -> socio { joins(:socio).where(socio_id: socio) }
  scope :para_listado,                 -> prevision: Prevision.default { de_prevision(prevision).preload(:socio, apartado: [:rubro, :prevision]).order(fecha: :desc) }
  scope :espera_pago_impuestos,        -> { where(espera_pago_impuestos: true).where(deposito_id: nil) }
  scope :para_seleccionar_en_deposito, -> { de_prevision_activa.espera_pago_impuestos }

  # == Methods ==

  delegate :fecha_valida?, to: :prevision, allow_nil: true
  delegate :monto_gastado, :monto_depositado, to: :prevision, allow_nil: true, prefix: true
  delegate :monto_maximo, :prevision, to: :apartado, allow_nil: true, prefix: true
  delegate :monto_gastado, :monto_disponible, :monto_reservado, to: :socio, allow_nil: true, prefix: true

  def supera_monto_socio?
    monto_a_aumentar > socio_monto_disponible.to_f
  end

  def prevision
    apartado_prevision
  end

  def validador_monto_reservado
    @validador_monto_reservado ||= validador_monto_reservado_default
  end

  def monto_reservado_updater
    @monto_reservado_updater ||= monto_reservado_updater_default
  end

  def to_be_paid?
    espera_pago_impuestos and deposito_id.blank?
  end

  def monto_a_reponer
    iva.to_f
  end

  def to_s
    "#{socio} - [#{apartado}] #{fecha}"
  end

private

  def fecha_dentro_de_vigencia_de_prevision
    errors.add :fecha, :invalid unless fecha_valida?(fecha)
  end

  def monto_no_supera_monto_maximo_de_apartado
    errors.add :monto, :exceeds_monto_apartado if supera_monto_apartado?
  end

  def supera_monto_apartado?
    monto_a_aumentar + monto_socio_gastado_en_apartado > apartado_monto_maximo.to_f
  end

  def monto_socio_gastado_en_apartado
    socio_monto_gastado(apartado).to_f
  end

  def monto_no_supera_monto_depositado
    errors.add :monto, :exceeds_monto_depositado if supera_monto_depositado?
  end

  def supera_monto_depositado?
    monto_a_aumentar + prevision_monto_gastado.to_f > prevision_monto_depositado.to_f
  end

  def monto_no_supera_monto_disponible
    errors.add :monto, :exceeds_monto_disponible if supera_monto_socio?
  end

  def monto_a_aumentar
    monto.to_f - monto_was.to_f
  end

  def monto_reservado_valido?
    errors.add :descontar_de_reservado, :not_enough_monto_reservado unless monto_reservado_suficiente?
  end

  def monto_reservado_suficiente?
    validador_monto_reservado.valid?
  end

  def descontar_de_reservado?
    ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include? descontar_de_reservado
  end

  def actualizar_monto_reservado
    monto_reservado_updater.call
  end

  def validador_monto_reservado_default
    GastoValidators::MontoReservadoValidator.new(self)
  end

  def monto_reservado_updater_default
    GastoValidators::MontoReservadoUpdater.new(self, socio.tope)
  end
end

# == Schema Information
#
# Table name: gastos
#
#  id                    :integer          not null, primary key
#  factura_xml           :string
#  factura_pdf           :string
#  solicitud             :string
#  monto                 :decimal(, )
#  fecha                 :date
#  metodo_pago           :integer          default(0)
#  descripcion           :text
#  socio_id              :integer
#  proveedor_id          :integer
#  apartado_id           :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  iva                   :decimal(, )
#  total                 :decimal(, )
#  espera_pago_impuestos :boolean          default(TRUE)
#  deposito_id           :integer
#
# Indexes
#
#  index_gastos_on_apartado_id   (apartado_id)
#  index_gastos_on_proveedor_id  (proveedor_id)
#  index_gastos_on_socio_id      (socio_id)
#
# Foreign Keys
#
#  fk_rails_5c1017f265  (socio_id => socios.id)
#  fk_rails_982ad725a5  (apartado_id => apartados.id)
#  fk_rails_a493c36920  (deposito_id => depositos.id)
#  fk_rails_e4c5f4d318  (proveedor_id => proveedores.id)
#
