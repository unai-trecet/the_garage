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

      before { post :create, garage: { number_levels: 3, number_lots: 5 } }
      
      it "creates a garage" do        
        expect(Garage.count).to eq(1)
      end

      it "creates a level associated to the created garage" do
        expect(Garage.last.levels.count).to eq(1)
      end

      it "redirects to show page" do
        expect(response).to redirect_to garage_path Garage.last.id     
      end
    end

    context "with invalid input" do

      before { post :create, garage: { number_lots: 5 } }

      it "does not create a garage" do        
        expect(Garage.count).to eq(0)        
      end

      it "renders new template" do
        expect(response).to render_template :new  
      end      
    end
  end

  describe "POST park_vehicle" do

    context "with valid input" do
      context "parking a vehicle" do
        context "the parking has room for the vehicle" do

          let(:garage) { Fabricate :garage, number_levels: 2, number_lots: 1  }

          before { garage.levels.create() }

          it "creates a new vehicle" do      
            post :park_vehicle, plate: "7777", type: "car", garage_id: garage.id, park_button: "Park vehicle"     
            expect(Vehicle.count).to eq(1)
          end

          it "creates a car if it was the selected option" do
            post :park_vehicle, plate: "7777", type: "car", garage_id: garage.id, park_button: "Park vehicle"
            expect(Car.count).to eq(1)
          end

          it "associates the vehicle to the garage" do
            post :park_vehicle, plate: "7777", type: "car", garage_id: garage.id, park_button: "Park vehicle"
            expect(garage.vehicles.last).to eq(Vehicle.last)
          end

          it "associates the vehicle to a level" do
            post :park_vehicle, plate: "7777", type: "car", garage_id: garage.id, park_button: "Park vehicle"
            expect(garage.lots.last.vehicle).to eq(Vehicle.last)
          end

          it "creates a new level if there is one allready full" do
            garage.vehicles.create(plate: '1234')

            post :park_vehicle, plate: "7777", type: "car", garage_id: garage.id, park_button: "Park vehicle"
            expect(garage.levels.count).to eq(2)
          end

          it "associates the vehicle to a lot" do
            post :park_vehicle, plate: "7777", type: "car", garage_id: garage.id, park_button: "Park vehicle" 
            expect(garage.levels.last.vehicles.last).to eq(Vehicle.last)
          end
        end

        context "the parking has no room for the vehicle" do 

          let(:garage) { Fabricate :garage, number_levels: 1, number_lots: 1 }
          
          before { garage.levels.create() }

          it "does not create a vehicle" do     
            garage.vehicles.create(plate: '1234')

            post :park_vehicle, plate: "7777", type: "car", garage_id: garage.id, park_button: "Park vehicle"   
            expect(Vehicle.count).to eq(1)
          end
        end
      end
      
      context "unparking a vehicle" do

        let(:garage) { Fabricate :garage, number_levels: 2, number_lots: 2  }
        let(:car) { Fabricate :vehicle }

        before do 
          garage.levels.create() 

          car2 = Fabricate :vehicle
          car3 = Fabricate :vehicle

          lot = Lot.create()
          lot.update_attributes(vehicle_id: car.id)   

          garage.vehicles << [car, car2, car3]
          garage.levels.create()          
        end

        context "with a valid plate" do

          before { post :park_vehicle, plate: car.plate, type: "car", garage_id: garage.id, unpark_button: "Unpark vehicle" }
          
          it "destroys the vehicle" do
            expect(Vehicle.count).to eq(2)
          end

          it "destroys the associated lot" do
            expect(Lot.count).to eq(0)
          end

          it "destroys the associated level if it is no need any more" do
            expect(garage.levels.count).to eq(1)            
          end

          it "Updates garage's number of vehicles" do
            expect(garage.vehicles.count).to eq(2) 
          end

          it "sets the notice" do
            expect(flash[:notice]).to be_present 
          end
        end

        context "with invalid plate" do

          before { post :park_vehicle, plate: "0000", type: "car", garage_id: garage.id, unpark_button: "Unpark vehicle" }

          it "does not destroy any vehicle" do
            expect(Vehicle.count).to eq(3)
          end

          it "does not destroy any lot" do
            expect(Lot.count).to eq(1)
          end

          it "does not update garage's number of vehicles" do
            expect(garage.vehicles.count).to eq(3) 
          end

          it "sets the error" do
            expect(flash[:error]).to be_present 
          end
        end
      end 
    end

    context "with invalid input" do

      let(:garage) { Fabricate :garage }
      
      it "does not create a vehicle" do   
        post :park_vehicle, type: "car", garage_id: garage.id  
        expect(Vehicle.count).to eq(0)
      end
    end
  end

  describe "POST find_vehicle" do

  end
end