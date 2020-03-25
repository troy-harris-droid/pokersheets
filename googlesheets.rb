require "google/apis/sheets_v4"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

class Googlesheets

  OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
  APPLICATION_NAME = "Google Sheets API Ruby Quickstart".freeze
  CREDENTIALS_PATH = "credentials.json".freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
  TOKEN_PATH = "token.yaml".freeze
  SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS
  SPREADSHEET_ID = # Example: "2WS_eGFxbGxpfvbsBWLRliQDxvE1dVeoDhdB_i8LBJuO"

  def call
    init_api
  end

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
  def authorize
    client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "default"
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url base_url: OOB_URI
      puts "Open the following URL in the browser and enter the " \
         "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

# Initialize the API
  def init_api
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
  end

  # https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/append
  def write(value)
    spreadsheet_id = SPREADSHEET_ID
    range_name = "'Pokersheets-write test'!A2"
    value_input_option = 'RAW'
    values = [value]
    value_range_object = Google::Apis::SheetsV4::ValueRange.new(range:  range_name,
                                                                values: values)
    result = @service.append_spreadsheet_value(spreadsheet_id,
                                              range_name,
                                              value_range_object,
                                              value_input_option: value_input_option)
    puts "#{result.updates.updated_cells} cells updated."

  end

end
