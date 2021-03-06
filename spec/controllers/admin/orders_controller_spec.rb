require 'spec_helper'

RSpec.describe Spree::Admin::OrdersController do

  context "with authorization" do
    stub_authorization!

    before do
      request.env["HTTP_REFERER"] = "http://localhost:3000"
    end

    let(:order) { mock_model Spree::Order, complete?: true, total: 100, number: 'R123456789' }

    before do
      allow(Spree::Order).to receive_message_chain(:includes, find_by!: order)
    end

    context '#reset_digitals' do
      it 'should reset digitals for an order' do
        expect(order).to receive(:reset_digital_links!)
        get :reset_digitals, params: { id: order.number }
        expect(response).to redirect_to(spree.edit_admin_order_path(order))
      end
    end
  end

end
