require 'test_helper'

class AccountTypeServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account_type_service = account_type_services(:one)
  end

  test "should get index" do
    get account_type_services_url
    assert_response :success
  end

  test "should get new" do
    get new_account_type_service_url
    assert_response :success
  end

  test "should create account_type_service" do
    assert_difference('AccountTypeService.count') do
      post account_type_services_url, params: { account_type_service: { account_type_id: @account_type_service.account_type_id, interval: @account_type_service.interval, service_id: @account_type_service.service_id, state: @account_type_service.state } }
    end

    assert_redirected_to account_type_service_url(AccountTypeService.last)
  end

  test "should show account_type_service" do
    get account_type_service_url(@account_type_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_account_type_service_url(@account_type_service)
    assert_response :success
  end

  test "should update account_type_service" do
    patch account_type_service_url(@account_type_service), params: { account_type_service: { account_type_id: @account_type_service.account_type_id, interval: @account_type_service.interval, service_id: @account_type_service.service_id, state: @account_type_service.state } }
    assert_redirected_to account_type_service_url(@account_type_service)
  end

  test "should destroy account_type_service" do
    assert_difference('AccountTypeService.count', -1) do
      delete account_type_service_url(@account_type_service)
    end

    assert_redirected_to account_type_services_url
  end
end
