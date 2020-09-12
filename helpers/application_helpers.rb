module ApplicationHelpers
    
    def json( dataset )
        if !dataset #.empty?
            return no_data!
        else
            JSON.pretty_generate(JSON.load(dataset.to_json)) + "\n" unless dataset.class == String
        end
    end

    def send_json json_dataset
        if !json_dataset #.empty?
            return no_data!
        else
            json_dataset
        end
    end 

    def no_data!
        response = { message: 'data not found.', status: 204 }.to_json
        json response
    end



    def current?(path='/')
        request.path_info==path ? "current": nil
    end
    
end