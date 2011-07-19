require 'spec_helper'

describe PaymentsController do

  def mock_payment(stubs={})
    @mock_payment ||= Payment.tap do |payment|
      payment.stubs(stubs) unless stubs.empty?
    end
  end

  def stub_auth
    controller.stubs(:check_authorization! => true)
  end

  def mock_transaction(stubs = {})
    @mock_transaction ||= Transaction.tap do |transaction|
      transaction.stubs(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all payments as @payments" do
      stub_auth
      Payment.stubs(:org => stub(:all => [mock_payment]) )

      get :index
      #puts assigns.keys
      assigns(:payments).should eq([mock_payment])
    end
  end

  describe "GET new" do
    it "assigns a new payment as @payment" do
      stub_auth
      mock_trans = mock_transaction(:new_payment => mock_payment)
      Transaction.stubs(:org => stub(:find => mock_trans) )

      get :new, :id => 1
      assigns(:transaction).should == mock_transaction
      assigns(:payment).should == mock_payment
    end
  end

  #describe "GET show" do
  #  it "assigns the requested payment as @payment" do
  #    Payment.stub(:find).with("37") { mock_payment }
  #    get :show, :id => "37"
  #    assigns(:payment).should be(mock_payment)
  #  end
  #end

  describe "POST create" do
    describe "with valid params" do
      before do
        stub_auth
      end 

      it "when stubed method for action_id 1-1" do
        mock_trans = mock_transaction(:new_contact_payment => mock_payment)
        Transaction.stubs(:org => stub(:find => mock_trans) )

        post :create, :payment => {:acount_id => '1-1' }
        assigns(:payment).should == mock_payment
      end

      it "incorrect stubed method for action_id 1-1 raises exeption" do
        mock_trans = mock_transaction(:new_contact_payment => mock_payment)
        Transaction.stubs(:org => stub(:find => mock_trans) )

        post :create, :payment => {:acount_id => '1' }
        assigns(:payment).should be(mock_payment)
      end

    end

    #describe "with invalid params" do
    #  it "assigns a newly created but unsaved payment as @payment" do
    #    Payment.stub(:new).with({'these' => 'params'}) { mock_payment(:save => false) }
    #    post :create, :payment => {'these' => 'params'}
    #    assigns(:payment).should be(mock_payment)
    #  end

    #  it "re-renders the 'new' template" do
    #    Payment.stub(:new) { mock_payment(:save => false) }
    #    post :create, :payment => {}
    #    response.should render_template("new")
    #  end
    #end

  end

  #describe "PUT update" do

  #  describe "with valid params" do
  #    it "updates the requested payment" do
  #      Payment.should_receive(:find).with("37") { mock_payment }
  #      mock_payment.should_receive(:update_attributes).with({'these' => 'params'})
  #      put :update, :id => "37", :payment => {'these' => 'params'}
  #    end

  #    it "assigns the requested payment as @payment" do
  #      Payment.stub(:find) { mock_payment(:update_attributes => true) }
  #      put :update, :id => "1"
  #      assigns(:payment).should be(mock_payment)
  #    end

  #    it "redirects to the payment" do
  #      Payment.stub(:find) { mock_payment(:update_attributes => true) }
  #      put :update, :id => "1"
  #      response.should redirect_to(payment_url(mock_payment))
  #    end
  #  end

  #  describe "with invalid params" do
  #    it "assigns the payment as @payment" do
  #      Payment.stub(:find) { mock_payment(:update_attributes => false) }
  #      put :update, :id => "1"
  #      assigns(:payment).should be(mock_payment)
  #    end

  #    it "re-renders the 'edit' template" do
  #      Payment.stub(:find) { mock_payment(:update_attributes => false) }
  #      put :update, :id => "1"
  #      response.should render_template("edit")
  #    end
  #  end

  #end

  #describe "DELETE destroy" do
  #  it "destroys the requested payment" do
  #    Payment.should_receive(:find).with("37") { mock_payment }
  #    mock_payment.should_receive(:destroy)
  #    delete :destroy, :id => "37"
  #  end

  #  it "redirects to the payments list" do
  #    Payment.stub(:find) { mock_payment }
  #    delete :destroy, :id => "1"
  #    response.should redirect_to(payments_url)
  #  end
  #end

end
