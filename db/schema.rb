# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_27_114956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "administrations", force: :cascade do |t|
    t.string "code"
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "departement"
    t.string "service"
  end

  create_table "nataffs", force: :cascade do |t|
    t.string "code"
    t.text "desc"
    t.boolean "full"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((code)::text) varchar_pattern_ops", name: "index_nataffs_on_lower_code_varchar_pattern_ops"
    t.index ["code"], name: "index_nataffs_on_code", unique: true
    t.index ["desc"], name: "index_nataffs_on_desc", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "nataffs_signalements", id: false, force: :cascade do |t|
    t.bigint "signalement_id"
    t.bigint "nataff_id"
    t.index ["nataff_id"], name: "index_nataffs_signalements_on_nataff_id"
    t.index ["signalement_id"], name: "index_nataffs_signalements_on_signalement_id"
  end

  create_table "natinfs", force: :cascade do |t|
    t.string "numero"
    t.text "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((numero)::text) varchar_pattern_ops", name: "index_natinfs_on_lower_numero_varchar_pattern_ops"
    t.index ["desc"], name: "index_natinfs_on_desc", opclass: :gin_trgm_ops, using: :gin
    t.index ["numero"], name: "index_natinfs_on_numero", unique: true
  end

  create_table "natinfs_signalements", id: false, force: :cascade do |t|
    t.bigint "signalement_id"
    t.bigint "natinf_id"
    t.index ["natinf_id"], name: "index_natinfs_signalements_on_natinf_id"
    t.index ["signalement_id"], name: "index_natinfs_signalements_on_signalement_id"
  end

  create_table "signalements", force: :cascade do |t|
    t.boolean "urgence"
    t.string "reference_administration"
    t.text "commentaire"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "createur_id", null: false
    t.bigint "administration_id", null: false
    t.string "date_faits"
    t.string "idj"
    t.string "lieux_faits"
    t.integer "status", default: 0
    t.index ["administration_id"], name: "index_signalements_on_administration_id"
    t.index ["createur_id"], name: "index_signalements_on_createur_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "prenom", null: false
    t.string "nom", null: false
    t.integer "role", default: 2, null: false
    t.string "telephone"
    t.bigint "administration_id"
    t.index ["administration_id"], name: "index_users_on_administration_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "signalements", "administrations"
  add_foreign_key "signalements", "users", column: "createur_id"
  add_foreign_key "users", "administrations"
end
