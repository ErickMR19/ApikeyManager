class ApiKeyManagerController < ApplicationController
   include ActionController::MimeResponds
  def index
    @apikeys = ApiKey.all
  end
  
  def create
    @newapikey = ApiKey.new(email: params[:email])
    @newapikey.save
    logger.info @newapikey.errors
    respond_to do |format|
      format.html { redirect_to action: 'index' }
      format.js
    end
  end
  
  def request_find_duplicates
    api_key = params[:api_key]
    data = params[:data]
    response = {code: 200, status: "success"}
    if ApiKey.valid_key?(api_key) 
      response[:duplicates] = find_duplicates(data)
      ApiKey.increment_num_requests(api_key)
    else
      response[:code] = 400
      response[:status] = "unauthorized"
    end
    render json: response, status: response[:code]
  end
  
  private
    def find_duplicates(array) 
      results = {}      
      array.each_with_index {
        |word, index|
        results[word] =  (results[word] && results[word].push(index)) || [index]
      }
      return results.select { |word| results[word].length > 1 }.map { |word, positions| {word: word, positions: positions} }
    end
end
