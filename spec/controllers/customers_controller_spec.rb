require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'GET customers#new' do
    it 'should render the new customer page' do
      get :new
      expect(response).to render_template :new
    end
  end
  describe 'POST customers#create' do
    context 'valid email' do
      it 'creates a new customer' do
        expect {
          post :create, params: { customer: { email: 'foo@bar.com' } }
        }.to change(Customer, :count).by(1)
      end
    end
    context 'invalid email' do
      it 'flashes an error message and shows the form' do
        post :create, params: { customer: { email: 'foobar' } }
        expect(flash[:error]).to be_present
        expect(response).to render_template :new
      end
    end
  end
  describe 'GET customers#show' do
    it 'shows a customer' do
      customer = Customer.create(email: 'test@test.com')
      get :show, params: { id: customer.id }
      expect(assigns(:customer)).to eq customer
    end
  end
end
