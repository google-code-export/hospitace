# encoding: utf-8

class Attachment < ActiveRecord::Base
  belongs_to :evaluation
  belongs_to :people
  belongs_to :form
  
  TYPES = %w[application\/pdf image\/.+]
  
  validate :validate_data
  validate :validate_type
  validate :data, :presence => true
  validate :people, :presence => true 
  
  def validate_data
    return if data.nil?
    errors[:data] << "should be less than 4MB" if data.size > 4.megabytes
  end
  
  def validate_type
    TYPES.each { |item| 
      return unless /#{item}/.match(content_type).nil?
    }
    errors[:data] << "nepodporovaný typ souboru"
  end
  
  def uploaded_file=(incoming_file)
    puts incoming_file.inspect
    data = incoming_file[:data]
    return if data.nil?
    self.filename = data.original_filename
    self.content_type = data.content_type
    self.data = data.read
  end
  
  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end
  
  private
  def sanitize_filename(filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
