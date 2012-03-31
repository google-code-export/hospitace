require 'uri'
require 'yajl'
require 'rest_client'
require 'restclient/components'
require 'rack/cache'

module KOSapi
  USERNAME = "kosapi4"
  PASSWORD = "IN_VoFuQnrUNdcYyltR47AZE"
  
  PARAM = "paging=false&level=1"
  
  API_VERSION = '2'
  API_URI     = "https://#{USERNAME}:#{PASSWORD}@kosapi.feld.cvut.cz/api/#{API_VERSION}/"

  require File.dirname(__FILE__) + '/kosapi/i18n'
  require File.dirname(__FILE__) + '/kosapi/model_helpers'
  require File.dirname(__FILE__) + '/kosapi/resource'

  require File.dirname(__FILE__) + '/kosapi/room'
  require File.dirname(__FILE__) + '/kosapi/semester'
  require File.dirname(__FILE__) + '/kosapi/user'
  require File.dirname(__FILE__) + '/kosapi/course'
  require File.dirname(__FILE__) + '/kosapi/course_instance'
  require File.dirname(__FILE__) + '/kosapi/parallel'
end