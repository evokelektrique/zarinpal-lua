local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("json")

local zarinpal = {
  api = {
    version = "v4",
    endpoints = {
      request = "/payment/request.json",
      verify = "/payment/verify.json",
    },
  }
}

zarinpal.__index = zarinpal

zarinpal.__newindex = function(_, key, value)
  zarinpal[key] = value
end

zarinpal.new = function()
  return setmetatable({}, zarinpal)
end

zarinpal.request = function(self, data)
  local url = self:generate_zarinpal_url() ..
              self.api.version ..
              self.api.endpoints.request

  local request_data = json.encode(data)
  local response = {}
  -- -- Send a http request to "Zarinpal" is endpoint and receive its data
  local result, response_code, response_headers, response_status = http.request({
    method = "POST",
    source = ltn12.source.string(request_data),
    url = url,
    headers = {
      ["content-type"] = "application/json",
      ["content-length"] = tostring(#request_data),
    },
    sink = ltn12.sink.table(response)
  })

  -- Convert the received request body data into string
  response = table.concat(response)

  -- Print the result as an error if the response header status is other than "OK/200"
  --
  -- TODO: Maybe display a meaningful error?
  --
  if response_code ~= 200 then error(response) end

  return json.decode(response)
end

zarinpal.verify = function(self)
  local url = self:generate_zarinpal_url() ..
              self.api.version ..
              self.api.endpoints.verify

  return url
end

zarinpal.generate_zarinpal_url = function(self)
  local base_url = ""
  if self.sandbox then
    base_url = "https://sandbox.zarinpal.com/pg/"
  else
    base_url = "https://api.zarinpal.com/pg/"
  end

  return base_url
end

return setmetatable(zarinpal, {
  __call = function(self, ...)
    return zarinpal.new(...)
  end
})
