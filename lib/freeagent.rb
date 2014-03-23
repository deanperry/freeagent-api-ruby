require 'freeagent/client'
require 'freeagent/errors' 

require 'freeagent/resource'
require 'freeagent/user'
require 'freeagent/company'
require 'freeagent/timeline_item'
require 'freeagent/attachment'
require 'freeagent/contact'
require 'freeagent/project'
require 'freeagent/task'
require 'freeagent/timeslip'
require 'freeagent/note'
require 'freeagent/recurring_invoice'
require 'freeagent/invoice'
require 'freeagent/bank_account'
require 'freeagent/estimate'
require 'freeagent/expense'
require 'freeagent/bank_transaction'
require 'freeagent/bank_transaction_explanation'

module FreeAgent
  class << self
    attr_accessor :environment
    attr_accessor :debug
    attr_reader :client
    
    def access_details(client_id, client_secret, access_token=nil)
      @client = Client.new(client_id, client_secret)
      @client.access_token = access_token if access_token
    end
  end
end
