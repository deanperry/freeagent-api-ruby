module FreeAgent
  class BankTransaction < Resource
    resource :bank_transaction

    resource_methods :find, :filter 

    attr_accessor :bank_account, :description, :is_manual, :bank_transactions_explanations
    decimal_accessor :amount, :unexplained_amount

    date_accessor :dated_on

    def self.find_all_by_bank_account(bank_account, options = {})
      options.merge!(bank_account: bank_account)
      BankTransaction.filter(options) 
    end

    def self.unexplained(bank_account, options = {})
      options.merge!(view: "unexplained", bank_account: bank_account)
      BankTransaction.filter(options)
    end

    def self.manual(bank_account, options = {})
      options.merge!(view: "manual", bank_account: bank_account)
      BankTransaction.filter(options)
    end

    def self.imported(bank_account, options = {})
      options.merge!(view: "imported", bank_account: bank_account)
      BankTransaction.filter(options)
    end

    def self.upload_statement(statement, bank_account)
      RestClient::Request.execute(method: :post, url: "#{FreeAgent::Client.site}/bank_transactions/statement?bank_account=#{bank_account}", payload: {statement: File.new(statement, "rb")}, headers: {"Authorization" => "Bearer #{FreeAgent.client.access_token.token}"})
    end
  end
end