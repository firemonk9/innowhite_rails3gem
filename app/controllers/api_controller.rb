class ApiController < ApplicationController
  require 'digest/sha1'
  require "innowhite"

  before_filter lambda {@innowhite = Innowhite.new}

  def create_room
    @res = @innowhite.create_room(params[:user_name],params[:meeting_name])

    render :update do |page|
      page.replace "result-create-room", "<div id='result-create-room'>#{debug(@res)}</div>"
    end
  end

  def join_room
    @res = @innowhite.join_meeting(params[:user_name], params[:meeting_id], params[:password])

    render :update do |page|
      page.replace "result-join-room", "<div id='result-join-room'>#{debug(@res)}</div>"
    end
  end

  def get_sessions
    @res = @innowhite.get_sessions
    render :update do |page|
      page.replace "result-get-sessions", "<div id='result-get-sessions'>#{debug(@res)}</div>"
    end
  end

  def date_prefix_conv(prefix)
    params[:meeting].update(prefix.to_sym => Time.new(*params[:meeting].select {|k, v| k.start_with?(prefix)}.map(&:last)))
  end

  def schedule_meeting
    date_prefix_conv("startTime")
    date_prefix_conv("endTime")
    @res = @innowhite.schedule_meeting(params[:meeting])
    render :update do |page|
      page.replace "result-schedule-meeting", "<div id='result-schedule-meeting'>#{debug(@res)}</div>"
    end
  end

  def past_sessions
    @res = @innowhite.past_sessions(params[:meeting])
    render :update do |page|
      page.replace "result-past-sessions", "<div id='result-past-sessions'>#{debug(@res)}</div>"
    end
  end

  def get_scheduled_list
    @res = @innowhite.get_scheduled_list(params[:meeting])
    render :update do |page|
      page.replace "result-get-scheduled-list", "<div id='result-get-scheduled-list'>#{debug(@res)}</div>"
    end
  end

  def cancel_meeting
    @res = @innowhite.cancel_meeting(params[:meeting][:meeting_id], params[:meeting][:password])
    render :update do |page|
      page.replace "result-cancel-meeting", "<div id='result-cancel-meeting'>#{debug(@res)}</div>"
    end
  end

  def update_schedule
    date_prefix_conv("startTime")
    date_prefix_conv("endTime")
    @res = @innowhite.update_schedule(params[:meetingID], params[:meeting])
    render :update do |page|
      page.replace "result-update-schedule", "<div id='result-update-schedule'>#{debug(@res)}</div>"
    end
  end

  def get_recordings
    @res = @innowhite.get_recordings(params[:meeting_id])
    render :update do |page|
      page.replace "result-get-recordings", "<div id='result-get-recordings'>#{debug(@res)}</div>"
    end
  end
end
