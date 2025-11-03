class ApplicationController < ActionController::API
    before_action :validate_user!


    private

    def validate_user!
        begin
            connector = Faraday.new(url: 'http://localhost:3001') do |frdy|
                @token = frdy.headers['Authorization']
            end

            response = connector.get("users/#{params[:id]}", { 'Authorization' => @token })

            unless response.success?
                # json_parsed = JSON.parse(response.body)
                render json: { error: "Exception in API" }, status: :unprocessable_entity and return
            end
        rescue Faraday::ConnectionFailed
            render json: { error: "UserService is unavailable" }, status: :service_unavailable and return
        end
    end
end
