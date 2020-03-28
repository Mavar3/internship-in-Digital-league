# frozen_string_literal: true

# class CreateVmService
#   def self.call
#     result = CheckVmService.call
#     return { error: 'invalid vm params' } unless result
#     NotifierService.call
#   end
# end
class CreateVmService
  def self.call
    return { error: 'invalid vm params' } unless CheckVmService.call

    NotifierService.call
    create_vm
  end

  def self.create_vm
    client = HTTPClient.new
    response = client.post('https://cloud.com/vms', { cpu: 1 }.to_json)
    JSON.parse(response.body)['vm_id']
  end
end
