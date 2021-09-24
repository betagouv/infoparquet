require "application_system_test_case"

class SignalementsTest < ApplicationSystemTestCase
  setup do
    @signalement = signalements(:one)
  end

  test "visiting the index" do
    visit signalements_url
    assert_selector "h1", text: "Signalements"
  end

  test "creating a Signalement" do
    visit signalements_url
    click_on "New Signalement"

    fill_in "Commentaire", with: @signalement.commentaire
    fill_in "Motif", with: @signalement.motif
    fill_in "Reference administration", with: @signalement.reference_administration
    fill_in "Reference juridiction", with: @signalement.reference_juridiction
    fill_in "Type", with: @signalement.type
    check "Urgence" if @signalement.urgence
    click_on "Create Signalement"

    assert_text "Signalement was successfully created"
    click_on "Back"
  end

  test "updating a Signalement" do
    visit signalements_url
    click_on "Edit", match: :first

    fill_in "Commentaire", with: @signalement.commentaire
    fill_in "Motif", with: @signalement.motif
    fill_in "Reference administration", with: @signalement.reference_administration
    fill_in "Reference juridiction", with: @signalement.reference_juridiction
    fill_in "Type", with: @signalement.type
    check "Urgence" if @signalement.urgence
    click_on "Update Signalement"

    assert_text "Signalement was successfully updated"
    click_on "Back"
  end

  test "destroying a Signalement" do
    visit signalements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Signalement was successfully destroyed"
  end
end
