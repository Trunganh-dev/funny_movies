# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  vote_type  :integer          default("up"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#  user_id    :bigint           not null
#
require "test_helper"

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
