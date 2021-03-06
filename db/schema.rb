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

ActiveRecord::Schema.define(:version => 20150204034251) do

  create_table "adm_user_groups", :force => true do |t|
    t.string   "name"
    t.integer  "account",    :default => 0, :null => false
    t.integer  "ip",         :default => 0, :null => false
    t.integer  "event",      :default => 0, :null => false
    t.integer  "building",   :default => 0, :null => false
    t.integer  "job",        :default => 0, :null => false
    t.integer  "comment",    :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "adm_users", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "hashed_pw"
    t.string   "salt"
    t.string   "verify_code"
    t.boolean  "verified"
    t.integer  "extend"
    t.string   "phone"
    t.string   "email"
    t.string   "department"
    t.integer  "campus_buildings_list_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "adm_users", ["campus_buildings_list_id"], :name => "index_adm_users_on_campus_buildings_list_id"

  create_table "admin_login_logs", :force => true do |t|
    t.integer  "adm_user_id"
    t.datetime "login_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "admin_login_logs", ["adm_user_id"], :name => "index_admin_login_logs_on_adm_user_id"

  create_table "announcemapsgroups", :force => true do |t|
    t.integer  "announcement_id"
    t.integer  "adm_group_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "announcemapsgroups", ["announcement_id"], :name => "index_announcemapsgroups_on_announcement_id"

  create_table "announcements", :force => true do |t|
    t.integer  "adm_user_id"
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "start_show"
    t.datetime "end_show"
  end

  create_table "campus_buildings_lists", :force => true do |t|
    t.string   "campus_name"
    t.string   "building_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "adm_user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "handling_adm_user_id"
    t.integer  "assigning_adm_user_id"
    t.string   "stage"
    t.text     "report"
    t.text     "adm_note"
    t.text     "handle_note"
    t.text     "change_note"
  end

  add_index "comments", ["adm_user_id"], :name => "index_comments_on_adm_user_id"

  create_table "event_adm_logs", :force => true do |t|
    t.integer  "adm_user_id"
    t.datetime "edit_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "event_map_id"
  end

  add_index "event_adm_logs", ["adm_user_id"], :name => "index_event_adm_logs_on_adm_user_id"
  add_index "event_adm_logs", ["event_map_id"], :name => "index_event_adm_logs_on_event_map_id"

  create_table "event_maps", :force => true do |t|
    t.integer  "thread_id"
    t.text     "name"
    t.text     "chinese_name"
    t.text     "description"
    t.text     "chinese_description"
    t.text     "suggestion"
    t.string   "cve_id"
    t.string   "category"
    t.string   "severity"
    t.string   "reference"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "threat_type"
  end

  create_table "fireeye_logs", :force => true do |t|
    t.string   "event_level"
    t.integer  "event_id"
    t.string   "malware_name"
    t.string   "src_ip"
    t.string   "dst_ip"
    t.datetime "log_time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "receive_from"
  end

  create_table "ip_maps", :force => true do |t|
    t.string   "ip"
    t.integer  "IPv4_1"
    t.integer  "IPv4_2"
    t.integer  "IPv4_3"
    t.integer  "IPv4_4"
    t.integer  "adm_user_id"
    t.string   "OS"
    t.string   "OS_others"
    t.string   "version"
    t.string   "place"
    t.string   "place_others"
    t.string   "use"
    t.string   "use_others"
    t.string   "user"
    t.integer  "campus_buildings_list_id"
    t.string   "room"
    t.integer  "extend"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.boolean  "block",                    :default => false, :null => false
    t.boolean  "always_visible",           :default => false, :null => false
    t.boolean  "always_handle",            :default => true,  :null => false
  end

  add_index "ip_maps", ["adm_user_id"], :name => "index_ip_maps_on_adm_user_id"
  add_index "ip_maps", ["campus_buildings_list_id"], :name => "index_ip_maps_on_campus_buildings_list_id"

  create_table "job_details", :force => true do |t|
    t.integer  "job_id"
    t.string   "src_ip"
    t.integer  "log_count"
    t.date     "log_date"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.boolean  "alert"
    t.string   "region"
    t.integer  "isflood_scan", :default => 0
    t.integer  "today_count",  :default => 0
    t.integer  "last_count",   :default => 0
  end

  add_index "job_details", ["job_id"], :name => "index_job_details_on_job_id"
  add_index "job_details", ["src_ip"], :name => "index_job_details_on_src_ip"

  create_table "job_logs", :force => true do |t|
    t.integer  "job_id"
    t.datetime "log_time"
    t.string   "victim_ip"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "threat_id"
    t.string   "action"
    t.string   "country"
    t.string   "threat_type"
    t.string   "src_ip"
  end

  add_index "job_logs", ["job_id"], :name => "index_job_logs_on_job_id"
  add_index "job_logs", ["log_time"], :name => "index_job_logs_on_log_time"
  add_index "job_logs", ["threat_id"], :name => "index_job_logs_on_threat_id"
  add_index "job_logs", ["victim_ip"], :name => "index_job_logs_on_victim_ip"

  create_table "job_messages", :force => true do |t|
    t.integer  "adm_user_id"
    t.integer  "job_id"
    t.integer  "stage_from"
    t.string   "type"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "job_threats", :force => true do |t|
    t.integer  "job_id"
    t.integer  "threat_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "serverity"
  end

  add_index "job_threats", ["job_id"], :name => "index_job_threats_on_job_id"

  create_table "jobs", :force => true do |t|
    t.integer  "assigning_adm_user_id"
    t.integer  "handling_adm_user_id"
    t.string   "stage1"
    t.string   "stage2"
    t.string   "stage3"
    t.string   "stage4"
    t.string   "stage5"
    t.boolean  "deleted",               :default => false, :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "ip_map_id"
    t.boolean  "PA",                    :default => true,  :null => false
    t.integer  "closing_adm_user_id"
    t.boolean  "always_visible",        :default => false, :null => false
    t.boolean  "always_handle",         :default => true,  :null => false
    t.string   "from"
  end

  add_index "jobs", ["ip_map_id"], :name => "index_jobs_on_ip_map_id"

  create_table "mail_configs", :force => true do |t|
    t.boolean  "meeting_notification", :default => false, :null => false
    t.boolean  "weekly_statistic",     :default => false, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "adm_user_id"
  end

  add_index "mail_configs", ["adm_user_id"], :name => "index_mail_configs_on_adm_user_id"

  create_table "outside_counts", :force => true do |t|
    t.integer  "sum"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "log_date"
    t.string   "src_ip"
    t.string   "country"
  end

  add_index "outside_counts", ["src_ip"], :name => "index_outside_counts_on_src_ip"

  create_table "outside_logs", :force => true do |t|
    t.integer  "outside_counts_id"
    t.datetime "log_time"
    t.string   "src_ip"
    t.string   "victim_ip"
    t.string   "threat_id"
    t.string   "action"
    t.string   "country"
    t.string   "serverity"
    t.string   "threat_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "outside_logs", ["log_time"], :name => "index_outside_logs_on_log_time"
  add_index "outside_logs", ["outside_counts_id"], :name => "index_outside_logs_on_outside_counts_id"
  add_index "outside_logs", ["threat_id"], :name => "index_outside_logs_on_threat_id"
  add_index "outside_logs", ["victim_ip"], :name => "index_outside_logs_on_victim_ip"

  create_table "permission_configs", :force => true do |t|
    t.integer  "adm_user_id"
    t.integer  "account",           :default => 0, :null => false
    t.integer  "ip",                :default => 0, :null => false
    t.integer  "event",             :default => 0, :null => false
    t.integer  "building",          :default => 0, :null => false
    t.integer  "job",               :default => 0, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "comment",           :default => 1, :null => false
    t.integer  "adm_user_group_id"
    t.integer  "announcement",      :default => 0, :null => false
  end

  add_index "permission_configs", ["adm_user_group_id"], :name => "index_permission_configs_on_adm_user_group_id"
  add_index "permission_configs", ["adm_user_id"], :name => "index_permission_configs_on_adm_user_id"

  create_table "permission_configs_groups", :force => true do |t|
    t.integer  "permission_config_id"
    t.integer  "adm_user_group_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "permission_configs_groups", ["permission_config_id"], :name => "index_permission_configs_groups_on_permission_config_id"

  create_table "s_assigns", :force => true do |t|
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "done_at"
  end

  add_index "s_assigns", ["job_id"], :name => "index_s_assigns_on_job_id"

  create_table "s_checks", :force => true do |t|
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "done_at"
  end

  add_index "s_checks", ["job_id"], :name => "index_s_checks_on_job_id"

  create_table "s_closeds", :force => true do |t|
    t.integer  "job_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.datetime "done_at"
    t.text     "close_directly_reason"
  end

  add_index "s_closeds", ["job_id"], :name => "index_s_closeds_on_job_id"

  create_table "s_handles", :force => true do |t|
    t.integer  "job_id"
    t.text     "handling_description"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.datetime "done_at"
  end

  add_index "s_handles", ["job_id"], :name => "index_s_handles_on_job_id"

  create_table "s_informs", :force => true do |t|
    t.integer  "job_id"
    t.text     "description_alternation"
    t.text     "name_alternation"
    t.text     "suggestion_alternation"
    t.string   "log_level"
    t.datetime "informed_at"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.datetime "done_at"
  end

  add_index "s_informs", ["job_id"], :name => "index_s_informs_on_job_id"

  create_table "trace_configs", :force => true do |t|
    t.integer  "adm_user_id"
    t.boolean  "login",       :default => false, :null => false
    t.boolean  "event_log",   :default => false, :null => false
    t.boolean  "assign",      :default => false, :null => false
    t.boolean  "closed",      :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "trace_configs", ["adm_user_id"], :name => "index_trace_configs_on_adm_user_id"

end
