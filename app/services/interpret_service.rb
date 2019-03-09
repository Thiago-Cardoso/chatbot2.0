class InterpretService
    def self.call action, params
      case action
      when "list", "search", "search_by_hashtag"
        FaqModule::ListService.new(params, action).call()  #call service
      when "create"
        FaqModule::CreateService.new(params).call() #call service
      when "remove"
        FaqModule::RemoveService.new(params).call()  #call service
      when "help"
        HelpService.call()
      else
        "Não compreendi o seu desejo"
      end
    end
end