# frozen_string_literal: true

class CreateAttendanceLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :attendance_logs do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
