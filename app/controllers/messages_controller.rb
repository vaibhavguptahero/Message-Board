class MessagesController < ApplicationController
    before_action :find_params, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index,:show]

    def index
        @messages= Message.all.order('created_at DESC')
    end

    def show 
    end


    def new
        @message=current_user.messages.build
    end

    def create
        @message=current_user.messages.build(message_params)
        if @message.save
            flash[:notice]= "Successfully Created Message"
            redirect_to messages_path
        else 
            render 'new'
        end
    end

    def edit
    end

    def update
        if @message.update(message_params)
            flash[:notice]="Successfully Updated Message"
            redirect_to message_path(@message)
        else
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
       if @message.destroy
        redirect_to messages_path
        flash[:notice]= "Successfully Deleted Message"
       else
        flash[:error]= "Message not deleted"
       end
    end

    private

    def message_params
        params.require(:message).permit(:title, :description)
    end

    def find_params
        @message=Message.find(params[:id])
    end
end
