class PriceService
    attr_reader :vm_par
    def initialize(vm_par)
        @vm_par = vm_par
    end
    def get_price(sorce = 'http://counting_serv:5678/')
        client = HTTPClient.new
        response = client.request(:get, sorce, vm_par)
        cost = response.body.to_i
    rescue
        raise ServerConection
    end
end
