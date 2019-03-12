require 'test_helper'

class JournalEntryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get journal_entry_index_url
    assert_response :success
  end

  test "should get show" do
    get journal_entry_show_url
    assert_response :success
  end

  test "should get new" do
    get journal_entry_new_url
    assert_response :success
  end

  test "should get create" do
    get journal_entry_create_url
    assert_response :success
  end

  test "should get edit" do
    get journal_entry_edit_url
    assert_response :success
  end

  test "should get update" do
    get journal_entry_update_url
    assert_response :success
  end

  test "should get destroy" do
    get journal_entry_destroy_url
    assert_response :success
  end

end
