require_relative './../../spec_helper.rb'
 
describe FaqModule::CreateService do
  before do
    @question = FFaker::Lorem.sentence
    @answer = FFaker::Lorem.sentence
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end
 
 
  describe '#call' do
    context "Without hashtag params" do
      it "will receive a error" do
        #create new faq
        @createService = FaqModule::CreateService.new({"question" => @question, "answer" => @answer})
        response = @createService.call()
        expect(response).to match("Hashtag Obrigatória")
      end
    end
 
    context "With Valid params" do
      before do
        @createService = FaqModule::CreateService.new({"question" => @question, "answer" => @answer, "hashtags" => @hashtags})
        @response = @createService.call()
      end
 
 
      it "Receive success message" do
        expect(@response).to match("Criado com sucesso")
      end
  
  
      it "Question and anwser is present in database" do
        #show last data, verificate if question is equal
        expect(Faq.last.question).to match(@question)
        expect(Faq.last.answer).to match(@answer)
      end
  
  
      it "Hashtags are created" do
         #call variables @hashtag, get text and separe,(, ) return example ["ruby", "sinatra"]
        expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
        expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
      end
    end
  end
end