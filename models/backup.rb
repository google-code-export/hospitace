# encoding: utf-8

##
# Backup Generated: backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:backup, 'Záloha databáze') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set db.name = :all (or leave blank)
    db.name               = "hospitace_development"
    db.username           = "root"
    db.password           = "koliko"
    db.host               = "localhost"
    db.port               = 3306
    db.additional_options = ["--single-transaction"]
    # Optional: Use to set the location of this utility
    #   if it cannot be found by name in your $PATH
    db.mysqldump_utility = "/usr/bin/mysqldump"
  end

  store_with Local do |local|
    local.path = '~/backups/'
    local.keep = 10
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip do |compression|
    compression.best = true
    compression.fast = false
  end

end
