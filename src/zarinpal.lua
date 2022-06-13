local zarinpal = {
  _metatable = "awfawf",
  api = {
    version = "v4",
    endpoints = {
      request = "/payment/request.json",
      verify = "/payment/verify.json",
    },
  },
}

zarinpal.__index = zarinpal

zarinpal.new = function(configuration)
  return setmetatable(configuration, zarinpal)
end

zarinpal.request = function(self)
  local url = self:generate_zarinpal_url() ..
              self.api.version ..
              self.api.endpoints.request

  return url
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
