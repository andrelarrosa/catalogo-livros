class AuthorsController < ApplicationController
    before_action :set_author, only: %i[ show edit update destroy ]

    # GET /authors
    def index
        @authors = Author.all
    end

    # GET /authors/1
    def show
    end

    # GET /authors/new
    def new
        @author = Author.new
    end

    # GET /authors/1/edit
    def edit
    end

    # POST /authors
    def create
        @author = Author.new(author_params)

        if @author.save
        redirect_to @author, notice: "Autor cadastrado com sucesso."
        else
        render :new, status: :unprocessable_content
        end
    end

    # PATCH/PUT /authors/1
    def update
        if @author.update(author_params)
        redirect_to @author, notice: "Autor atualizado com sucesso.", status: :see_other
        else
        render :edit, status: :unprocessable_content
        end
    end

    # DELETE /authors/1
    def destroy
        @author.destroy!
        redirect_to authors_path, notice: "Autor removido com sucesso.", status: :see_other
    end

    private
        def set_author
            @author = Author.find(params.expect(:id))
        end

        def author_params
            params.expect(author: [ :name, :bio, :birth_year ])
        end
    end
