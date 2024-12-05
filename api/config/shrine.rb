require "shrine"
require "shrine/storage/file_system"

module ShrineSetup
  def self.setup
    Shrine.storages = {
      cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
      store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"),
    }

    Shrine.plugin :activerecord
    Shrine.plugin :validation_helpers
    Shrine.plugin :determine_mime_type
    Shrine.plugin :cached_attachment_data
  end
end
