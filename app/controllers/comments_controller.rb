class CommentsController < ApplicationController
    before_action :find_message
    before_action :find_comment, only: [:show, :edit,:update, :destroy]
    before_action :authenticate_user!
    def create
       
        @comment= @message.comments.create(comment_params)
        @comment.user_id= current_user.id

        if @comment.save
            redirect_to message_path(@message)
        else
            render 'new'
        end
    end

    def edit
       
      
    end

    def update
        if @comment.update(comment_params)
            redirect_to message_path(@message)
        else
            render 'edit'
        end
    end

    def destroy
        if @comment.destroy
            redirect_to message_path(@message)
            flash[:notice]= "Successfully Deleted Comment"
           else
            flash[:error]= "Comment not deleted"
           end
    end



    private

    def comment_params
        params.require(:comment).permit(:content)
    end

    def find_message
        @message=Message.find(params[:message_id])
    end

    
    def find_comment
        @comment = @message.comments.find(params[:id])
    end

end
