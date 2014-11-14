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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141113002256) do

  create_table "grades", :force => true do |t|
    t.string  "sem"
    t.integer "year"
    t.string  "dept"
    t.integer "courseno"
    t.integer "courseno2"
    t.integer "a"
    t.integer "b"
    t.integer "c"
    t.integer "d"
    t.integer "f"
    t.float   "gpr"
    t.integer "i"
    t.integer "s"
    t.integer "u"
    t.integer "q"
    t.integer "x"
    t.integer "total"
    t.string  "instructor"
  end

end
