class JournalEntriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @journal_entries = current_user.journal_entries.all
    render json: {
      message: "ok", 
      journal_entries: @journal_entries
    }
  end

  def show
    begin
      @journal_entry = current_user.journal_entries.find(params[:id])
      render json: {
        message: "ok",
        journal_entry: @journal_entry
      }
    rescue ActiveRecord::RecordNotFound
      render json: {
        error: "Could not find the journal entry with that ID", 
      },
      status: 404
    rescue Exception
      render json: {
        message: "There was some other error" 
      }, 
      status: 500
    end
  end

  def new
      @journal_entry = current_user.journal_entries.new
  end

  def create
    @journal_entry = current_user.journal_entries.new(entry_params)
    @journal_entry.save!
    render json: {
      message: "New journal entry created",
      journal_entry: @journal_entry
    }
  end

  def edit
    @journal_entry = current_user.journal_entries.find(params[:id])
    render json: {
      message: "Journal entry selected for update", 
      journal_entry: @journal_entry
    }
  end

  def update
    begin
      @journal_entry = current_user.journal_entries.find(params[:id])
      @journal_entry.update_attributes(entry_params)
    rescue Exception 
      render json: {
        message: "There was some other error" 
      }, 
      status: 500
    end
  end

  def destroy
    begin
      @journal_entry = current_user.journal_entries.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {
        message: "Could not find the journal entry with that ID"
      }, 
      status: 404 
    rescue Exception 
      render json: {
        message: "There was some other error" 
      }, 
      status: 500
    end
  end

  private

  def entry_params
    params.require(:journal_entry).permit(:title, :content)
  end

end
