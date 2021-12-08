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

ActiveRecord::Schema.define(version: 2021_12_08_134344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administration_services", force: :cascade do |t|
    t.string "nom"
    t.bigint "administration_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["administration_id"], name: "index_administration_services_on_administration_id"
  end

  create_table "administrations", force: :cascade do |t|
    t.string "code"
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "nataff"
    t.string "natinf"
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
    t.integer "role", default: 1, null: false
    t.string "telephone"
    t.bigint "administration_service_id"
    t.index ["administration_service_id"], name: "index_users_on_administration_service_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "administration_services", "administrations"
  add_foreign_key "signalements", "administrations"
  add_foreign_key "signalements", "users", column: "createur_id"
  add_foreign_key "users", "administration_services"
end
