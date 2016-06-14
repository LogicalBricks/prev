# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160612213043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agrupadores", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "apartados", force: :cascade do |t|
    t.decimal  "monto_maximo"
    t.integer  "rubro_id"
    t.integer  "prevision_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "apartados", ["prevision_id"], name: "index_apartados_on_prevision_id", using: :btree
  add_index "apartados", ["rubro_id"], name: "index_apartados_on_rubro_id", using: :btree

  create_table "comisiones", force: :cascade do |t|
    t.decimal  "monto"
    t.string   "descripcion"
    t.date     "fecha"
    t.integer  "prevision_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.date     "fecha_reposicion"
    t.text     "comentario"
    t.integer  "deposito_id"
  end

  add_index "comisiones", ["prevision_id"], name: "index_comisiones_on_prevision_id", using: :btree

  create_table "depositos", force: :cascade do |t|
    t.decimal  "monto"
    t.date     "fecha"
    t.text     "descripcion"
    t.integer  "prevision_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "pago_de_comisiones_o_impuestos", default: false
    t.string   "referencia"
  end

  add_index "depositos", ["prevision_id"], name: "index_depositos_on_prevision_id", using: :btree

  create_table "gastos", force: :cascade do |t|
    t.string   "factura_xml"
    t.string   "factura_pdf"
    t.string   "solicitud"
    t.decimal  "monto"
    t.date     "fecha"
    t.integer  "metodo_pago",           default: 0
    t.text     "descripcion"
    t.integer  "socio_id"
    t.integer  "proveedor_id"
    t.integer  "apartado_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "iva"
    t.decimal  "total"
    t.boolean  "espera_pago_impuestos", default: true
    t.integer  "deposito_id"
  end

  add_index "gastos", ["apartado_id"], name: "index_gastos_on_apartado_id", using: :btree
  add_index "gastos", ["proveedor_id"], name: "index_gastos_on_proveedor_id", using: :btree
  add_index "gastos", ["socio_id"], name: "index_gastos_on_socio_id", using: :btree

  create_table "previsiones", force: :cascade do |t|
    t.date     "fecha_inicial"
    t.date     "fecha_final"
    t.decimal  "monto"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.decimal  "monto_remanente"
    t.decimal  "monto_presupuestado"
  end

  create_table "proveedores", force: :cascade do |t|
    t.string   "nombre"
    t.string   "rfc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_usuarios", id: false, force: :cascade do |t|
    t.integer "rol_id",     null: false
    t.integer "usuario_id", null: false
  end

  create_table "rubros", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "socios", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "socios", ["usuario_id"], name: "index_socios_on_usuario_id", using: :btree

  create_table "topes", force: :cascade do |t|
    t.decimal  "monto"
    t.integer  "prevision_id"
    t.integer  "socio_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.decimal  "monto_reservado"
  end

  add_index "topes", ["prevision_id"], name: "index_topes_on_prevision_id", using: :btree
  add_index "topes", ["socio_id"], name: "index_topes_on_socio_id", using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.integer  "rol",                    default: 0
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "apartados", "previsiones"
  add_foreign_key "apartados", "rubros"
  add_foreign_key "comisiones", "previsiones"
  add_foreign_key "depositos", "previsiones"
  add_foreign_key "gastos", "apartados"
  add_foreign_key "gastos", "depositos"
  add_foreign_key "gastos", "proveedores"
  add_foreign_key "gastos", "socios"
  add_foreign_key "socios", "usuarios"
  add_foreign_key "topes", "previsiones"
  add_foreign_key "topes", "socios"
end
