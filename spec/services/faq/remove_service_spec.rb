require_relative './../../spec_helper.rb'


describe FaqModule::RemoveService do
  describe '#call' do
    context "Valid ID" do
      before do
        #create a fact passed um object with id
        faq = create(:faq)
        @removeService = FaqModule::RemoveService.new({"id" => faq.id})
      end

      it "Return success message" do
        #call service
        response = @removeService.call()
        expect(response).to match("Deletado com sucesso")
      end

      it "Remove Faq from database" do
        expect(Faq.all.count).to eq(1)
        response = @removeService.call()
        expect(Faq.all.count).to eq(0)
      end
    end

    context "Invalid ID" do
      it "return error message" do
         #if remove question with invalid id - generate a sorted id
        @removeService = FaqModule::RemoveService.new({"id" => rand(1..9999)})
        #call service
        response = @removeService.call()
        
         #return invalid question
        expect(response).to match("Questão inválida, verifique o Id")
      end
    end
  end
end