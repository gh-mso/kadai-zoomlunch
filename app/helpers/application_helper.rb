require 'net/https'
require 'net/http'
require 'uri'
require 'json'

module ApplicationHelper
    class TS_Zoom
        def initialize
            @api_key = "aaa"
            @secret  = "bbb"
            @user_id = "ccc"
            @jwt = "ddd"
            @meeting_url = "ddd"
        end
        def GenerateJWT
            payload = { 
                iss: @api_key,
                exp: Time.now.to_i + 4 * 36000
            }
            token = JWT.encode payload, @secret, 'HS256'
            return token
        end

        def GetUserData(_token)
            uri = URI.parse("https://api.zoom.us/v2/users")
            request = Net::HTTP::Get.new(uri)
            request["Authorization"] = "Bearer "+_token
            req_options = {
                use_ssl: uri.scheme == "https",
            }
            response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
                http.request(request)
            end
            result = JSON.parse(response.body)
            return result["users"][0]["id"].to_s
        end

        def GetMeetingURL
            @jwt = self.GenerateJWT
            @user_id = self.GetUserData(@jwt)
            @meeting_url = "https://api.zoom.us/v2/users/#{@user_id}/meetings"

            uri = URI.parse(@meeting_url)
            http = Net::HTTP.new(uri.host, uri.port)

            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE

            req = Net::HTTP::Post.new(uri.path)
            req["Authorization"] = "Bearer #{@jwt}"
            aa = "Bearer #{@jwt}"
            puts aa
            req["Content-Type"] = "application/json"
            req.body = {
                "type":1,
                }.to_json
            res = http.request(req)
            puts res.class
            puts res.code
            puts res.body
            return res
        end
    end
end