# frozen_string_literal: true

json.array! @attendance_logs, partial: 'attendance_logs/attendance_log', as: :attendance_log
