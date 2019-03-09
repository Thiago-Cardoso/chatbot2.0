require_relative './../../spec_helper.rb'
 
 
describe FaqModule::ListService do
  describe '#call' do
    context "list command" do
      context "Zero faqs in database" do
        it "Return don't find message" do
          #list not necessity parameters
          @listService = FaqModule::ListService.new({}, 'list')
    
          #call and wait not found
          response = @listService.call()
          expect(response).to match("Nada encontrado")
        end
      end
 
      context "Two faqs in database" do
        it "Find questions and answer in response" do
          @listService = FaqModule::ListService.new({}, 'list')
            
           #create a factory
          faq1 = create(:faq)
          faq2 = create(:faq)
            
          #list of commands question and answer
          response = @listService.call()
    
          #if exists the questions
          expect(response).to match(faq1.question)
          expect(response).to match(faq1.answer)
    
          expect(response).to match(faq2.question)
          expect(response).to match(faq2.answer)
        end
      end
    end
 
    context "search command" do
      context "Empty query" do
        it "return don't find message" do
         
          @listService = FaqModule::ListService.new({'query' => ''}, 'search')
            
          
          response = @listService.call()
          expect(response).to match("Nada encontrado")
        end  
      end
 
      context "Valid query" do
        it "find question and answer in response" do
          #create new faq
          faq = create(:faq)
    
           #separate in space and sample sorted someone array word
          @listService = FaqModule::ListService.new({'query' => faq.question.split(" ").sample}, 'search')
    
          #call list
          response = @listService.call()
            
          #verificate if reponse is correct
          expect(response).to match(faq.question)
          expect(response).to match(faq.answer)
        end
      end
    end
 
    context "search_by_hashtag command" do
      context "Invalid hashtag" do
        it "return don't find message" do
             #passed hashtag empty
          @listService = FaqModule::ListService.new({'query' => ''}, 'search_by_hashtag')
            
          #call list
          response = @listService.call()
          #return message not found
          expect(response).to match("Nada encontrado")
        end
      end
 
      context "Valid hashtag" do
        it "With valid hashtag, find question and answer in response" do
          #create a faq
          faq = create(:faq)
          #create a hashtag associated 
          hashtag = create(:hashtag)
           #create intermediate beetween hashtag and faq
          create(:faq_hashtag, faq: faq, hashtag: hashtag)
    
          #get hashtag.name and passed with parameters
          @listService = FaqModule::ListService.new({'query' => hashtag.name}, 'search_by_hashtag')
    
          #call service
          response = @listService.call()
    
          #show the answer and question
          expect(response).to match(faq.question)
          expect(response).to match(faq.answer)
        end
      end
    end    
  end
end