# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'attendance_logs/index', type: :view do
  before(:each) do
    assign(:attendance_logs, [
             AttendanceLog.create!(
               event_id: 2,
               user_id: 3
             ),
             AttendanceLog.create!(
               event_id: 2,
               user_id: 3
             )
           ])
  end

  it 'renders a list of attendance_logs' do
    render
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
  end
end
