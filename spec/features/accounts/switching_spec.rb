require "rails_helper"

describe "Switching accounts" do
  let(:account_1) do
    # "Account '#'1"っていう書き方するんだ.
    FactoryGirl.create(:account,
    name: "Account #1",
    subdomain: "account1"
    )
  end

  let(:account_2) do
  FactoryGirl.create(:account,
    name: "Account #2",
    subdomain: "account2"
    )
  end

  before do
    account_2.users << account_1.owner
    login_as(account_1.owner)
  end

  it "can switch between accounts" do
    set_subdomain(account_1.subdomain)
    visit root_url

    # subdomainなしのroot_urlへ。ログインは保持
    click_link "Twist"
    expect(page.current_url).to eq(root_url(subdomain: nil))
    click_link "Account #2"
    expect(page.current_url).to eq(root_url(subdomain: account_2.subdomain))

    click_link "Twist"
    expect(page.current_url).to eq(root_url(subdomain: nil))
    click_link "Account #1"
    expect(page.current_url).to eq(root_url(subdomain: account_1.subdomain))
  end
end
