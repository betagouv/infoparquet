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

ActiveRecord::Schema.define(version: 2021_09_21_123826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entities", force: :cascade do |t|
    t.string "name"
    t.string "service"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "departement", null: false
    t.index ["parent_id"], name: "index_entities_on_parent_id"
  end

  create_table "signalements", force: :cascade do |t|
    t.string "type_signalement"
    t.boolean "urgence"
    t.text "motif"
    t.string "reference_administration"
    t.text "commentaire"
    t.string "reference_juridiction"
    t.bigint "demandeur_id", null: false
    t.bigint "instructeur_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["demandeur_id"], name: "index_signalements_on_demandeur_id"
    t.index ["instructeur_id"], name: "index_signalements_on_instructeur_id"
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
    t.bigint "entity_id"
    t.string "nom", null: false
    t.integer "role", default: 1, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["entity_id"], name: "index_users_on_entity_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "entities", "entities", column: "parent_id"
  add_foreign_key "signalements", "users", column: "demandeur_id"
  add_foreign_key "signalements", "users", column: "instructeur_id"
  add_foreign_key "users", "entities"
end
