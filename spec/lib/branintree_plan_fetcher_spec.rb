# HACK: アプリ本来のビジネスロジックとは違うのでlibで。
# 外部APIを使う時はlibだったりするのかな。
require "rails_helper"
require "braintree_plan_fetcher"

describe BraintreePlanFetcher do
  let(:faux_plan) do
    # HACK: dobule使うの初めて見た。。。使えるんだね。
    double("Plan",
           id: "starter",
           name: "Starter",
           price: "9.95"
          )
  end

  it "fetches and stores plans" do
    expect(Braintree::Plan).to receive(:all).and_return([faux_plan])
    expect(Plan).to receive(:create).with({
      braintree_id: "starter",
      name: "Starter",
      price: "9.95"
    })

    BraintreePlanFetcher.store_locally
  end
end
