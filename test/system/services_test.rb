require "application_system_test_case"

class ServicesTest < ApplicationSystemTestCase
  setup do
    @service = services(:one)
  end

  test "visiting the index" do
    visit services_url
    assert_selector "h1", text: "Services"
  end

  test "creating a Service" do
    visit services_url
    click_on "New Service"

    fill_in "De name", with: @service.de_name
    fill_in "De type", with: @service.de_type
    fill_in "Name", with: @service.name
    fill_in "Rate", with: @service.rate
    fill_in "Url", with: @service.url
    click_on "Create Service"

    assert_text "Service was successfully created"
    click_on "Back"
  end

  test "updating a Service" do
    visit services_url
    click_on "Edit", match: :first

    fill_in "De name", with: @service.de_name
    fill_in "De type", with: @service.de_type
    fill_in "Name", with: @service.name
    fill_in "Rate", with: @service.rate
    fill_in "Url", with: @service.url
    click_on "Update Service"

    assert_text "Service was successfully updated"
    click_on "Back"
  end

  test "destroying a Service" do
    visit services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Service was successfully destroyed"
  end
end
