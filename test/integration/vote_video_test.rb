require "test_helper"

class VoteVideoTest < ActionDispatch::IntegrationTest
  fixtures :all

  def setup
    @one = movies(:movie1)
    @two = movies(:movie2)
    @user = users(:user1)

    login(@user)
  end

  test 'Unvoted down a new movie' do
    visit root_path

    assert_selector 'i', class: 'fa fa-thumbs-down fa-2x'
    assert_selector 'h4', text: @one.title
    assert_selector 'p', text: "Shared by: #{@user.email}"

    find("#vote-#{@one.id}").click

    assert page.has_content?('Unvote Success')

    within ".movie-2-#{@one.id}" do |scope|
      assert page.has_content?(@one.vote_ups_count)
    end
  end

  test 'Vote up a new movie' do
    visit root_path

    assert_selector 'h4', text: @two.title
    assert_selector 'p', text: "Shared by: #{@user.email}"
    assert_selector 'i', class: 'fa fa-thumbs-o-down fa-2x'
    assert_selector 'i', class: 'fa fa-thumbs-o-up fa-2x'

    find("#vote-up-#{@two.id}").click

    @two.reload

    assert page.has_content?('Vote Success')
    
    within ".movie-1-#{@two.id}" do |scope|
      assert page.has_content?(@two.vote_ups_count)
    end
  end
end
