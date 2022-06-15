# zarinpal-lua
Easily use Zarinpal in your Lua applications **(Still in development)**

## Usage
```lua
-- Import the module
zarinpal = require("zarinpal")

-- Required options for a transaction request
data = {
  -- Money amount of transaction
  amount = 20000,
  -- Your secret 36 character merchant code
  merchant_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  -- Description for the transaction
  description = "Test description",
  -- Redirect url
  callack_url = 'http://localhost:8000/',
  -- Customer phone number
  mobile = "09000000000",
  -- Customer email address
  email = "customer_email@example.com",
}

-- Initializing the module, and there are two ways to instance a `zarinpal`,
--
-- `x = zarinpal(your_data_table)`
-- `y = zarinpal.new(your_data_table)`
--
request = zarinpal.new()
-- Gateway mode(Optional) default is set to "api"
request.sandbox = true
request_result = zarinpal:request(data)

print("Result:", request_result)
```
