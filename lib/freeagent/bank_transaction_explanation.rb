module FreeAgent
  class BankTransactionExplanation < Resource
    resource :bank_transaction_explanation

    resource_methods :find, :filter 

    # attr_accessor :bank_account, :description, :is_manual, :bank_transactions_explanations
    attr_accessor :bank_account, :bank_transaction, :dated_on, :manual_sales_tax_amount, :description, :gross_value
    attr_accessor :foreign_currency_value, :rebill_type, :rebill_factor, :category, :attachment


    # transfer_bank_account (Required when transferring money between accounts)
    # asset_life_years (Required for capital asset purchase. The integer number of years over which the asset should be depreciated.)
    # attachment Hash
    # data must contain the binary data of the file being attached, encoded as Base64.
    # file_name
    # description
    # content_type can be one of the following:
    # image/png
    # image/x-png
    # image/jpeg
    # image/jpg
    # image/gif
    # application/x-pdf


    decimal_accessor :gross_value

    date_accessor :dated_on

    def self.find_all_by_bank_account(bank_account, options = {})
      options.merge!(bank_account: bank_account)
      BankTransactionExplanation.filter(options) 
    end

    def self.find(transaction, options = {})
      options.merge!(transaction: transaction)
      BankTransactionExplanation.filter(options) 
    end

    def self.create_for_transaction(bank_transaction, date, description, value, category, options = {})
      FreeAgent.client.post "bank_transaction_explanations",
      {
        bank_transaction_explanation: 
        {
          bank_transaction: bank_transaction,
          dated_on: date,
          description: description,
          gross_value: value,
          category: category
        }
      }
    end

    def self.create_for_account(bank_account, date, description, value, category, options = {})
      FreeAgent.client.post "bank_transaction_explanations",
      {
        bank_transaction_explanation: 
        {
          bank_account: bank_account,
          dated_on: date,
          description: description,
          gross_value: value,
          category: category
        }
      }
    end
  end
end