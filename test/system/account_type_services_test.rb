require "application_system_test_case"

class AccountTypeServicesTest < ApplicationSystemTestCase
  setup do
    @account_type_service = account_type_services(:one)
  end

  test "visiting the index" do
    visit account_type_services_url
    assert_selector "h1", text: "Account Type Services"
  end

  test "creating a Account type service" do
    visit account_type_services_url
    click_on "New Account Type Service"

    fill_in "Account type", with: @account_type_service.account_type_id
    fill_in "Interval", with: @account_type_service.interval
    fill_in "Service", with: @account_type_service.service_id
    fill_in "State", with: @account_type_service.state
    click_on "Create Account type service"

    assert_text "Account type service was successfully created"
    click_on "Back"
  end

  test "updating a Account type service" do
    visit account_type_services_url
    click_on "Edit", match: :first

    fill_in "Account type", with: @account_type_service.account_type_id
    fill_in "Interval", with: @account_type_service.interval
    fill_in "Service", with: @account_type_service.service_id
    fill_in "State", with: @account_type_service.state
    click_on "Update Account type service"

    assert_text "Account type service was successfully updated"
    click_on "Back"
  end

  test "destroying a Account type service" do
    visit account_type_services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Account type service was successfully destroyed"
  end
end
