ActiveRecord::Schema.define(version: 20180304173826) do
  enable_extension 'plpgsql'
  enable_extension 'pgcrypto'
  enable_extension 'uuid-ossp'

  create_table 'event_store_events', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'event_type', null: false
    t.text 'metadata'
    t.text 'data', null: false
    t.datetime 'created_at', null: false
    t.index ['created_at'], name: 'index_event_store_events_on_created_at'
  end

  create_table 'event_store_events_in_streams', id: :serial, force: :cascade do |t|
    t.string 'stream', null: false
    t.integer 'position'
    t.uuid 'event_id', null: false
    t.datetime 'created_at', null: false
    t.index ['created_at'], name: 'index_event_store_events_in_streams_on_created_at'
    t.index ['stream', 'event_id'], name: 'index_event_store_events_in_streams_on_stream_and_event_id', unique: true
    t.index ['stream', 'position'], name: 'index_event_store_events_in_streams_on_stream_and_position', unique: true
  end

  create_table 'questions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'creator_id', null: false
    t.string 'title', null: false
    t.string 'body', null: false
    t.jsonb 'answers', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index 'to_tsvector('english'::regconfig, (((title)::text || ' '::text) || (body)::text))', name: 'questions_idx', using: :gin
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'provider'
    t.string 'uid'
    t.string 'name'
    t.string 'email'
    t.string 'image'
    t.string 'oauth_token'
    t.string 'oauth_refresh_token'
    t.datetime 'oauth_expires_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
