require 'rails_helper'

describe GaragesController do 
  describe "GET new" do
    it "sets @garage variable" do
      get :new
      expect(assigns :garage).to be_instance_of Garage      
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "creates a garage" do
        post :create, garage: { levels: 3, lots: 5 }
        expect(Garage.count).to eq(1)
      end

      it "redirects to show page" do
        post :create, garage: { levels: 3, lots: 5 }
        expect(response).to redirect_to garage_path Garage.last.id     
      end
    end

    context "with invalid input" do
      it "does not create a garage" do
        post :create, garage: { lost: 5 }
        expect(Garage.count).to eq(0)        
      end

      it "renders new template" do
        post :create, garage: { levels: 3, lots: 5 }
        expect(response).to render_template :new  
      end      
    end
  end
end