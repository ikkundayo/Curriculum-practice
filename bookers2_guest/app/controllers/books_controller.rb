class BooksController < ApplicationController

  def index
     @book = Book.new
     @books = Book.all
     @user = User.find(current_user.id)
  end

  def show
     @book = Book.new
     @books = Book.find(params[:id])
     @user = @books.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if
      @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index

    end
  end

  def edit
    @books = Book.find(params[:id])
    if @books.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @books = Book.find(params[:id])
    if
      @books.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@books)
    else
      render :edit
    end
  end


  def destroy
    @books = Book.find(params[:id])
    @books.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
