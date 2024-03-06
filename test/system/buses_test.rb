require "application_system_test_case"

class BusesTest < ApplicationSystemTestCase
  setup do
    @bus = buses(:one)
  end

  test "visiting the index" do
    visit buses_url
    assert_selector "h1", text: "Buses"
  end

  test "should create bus" do
    visit buses_url
    click_on "New bus"

    fill_in "Name", with: @bus.name
    fill_in "Registration no", with: @bus.registration_no
    fill_in "Route", with: @bus.route
    fill_in "Seats", with: @bus.number_of_seats
    fill_in "User", with: @bus.user_id
    click_on "Create Bus"

    assert_text "Bus was successfully created"
    click_on "Back"
  end

  test "should update Bus" do
    visit bus_url(@bus)
    click_on "Edit this bus", match: :first

    fill_in "Name", with: @bus.name
    fill_in "Registration no", with: @bus.registration_no
    fill_in "Route", with: @bus.route
    fill_in "Seats", with: @bus.number_of_seats
    fill_in "User", with: @bus.user_id
    click_on "Update Bus"

    assert_text "Bus was successfully updated"
    click_on "Back"
  end

  test "should destroy Bus" do
    visit bus_url(@bus)
    click_on "Destroy this bus", match: :first

    assert_text "Bus was successfully destroyed"
  end
end
