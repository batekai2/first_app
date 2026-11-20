class Rack::Attack
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?("/assets")
  end

  throttle("logins/ip", limit: 10, period: 1.minute) do |req|
    req.ip if req.path == "/login" && req.post?
  end

  throttle("posts/ip", limit: 20, period: 1.minute) do |req|
    req.ip if req.path == "/posts" && req.post?
  end

  throttle("posts/account", limit: 30, period: 10.minutes) do |req|
    if req.path == "/posts" && req.post?
      req.env["rack.session"]&.dig("user_id")
    end
  end

  self.throttled_responder = lambda do |_request|
    [
      429,
      { "Content-Type" => "text/plain; charset=utf-8" },
      ["リクエストが多すぎます。しばらく待ってから再度お試しください。\n"]
    ]
  end
end
