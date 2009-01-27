class DogsController < ApplicationController
  # GET /dogs
  # GET /dogs.xml
  
  before_filter :find_person
  
  def index
    @dogs = @person.dogs.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dogs }
      format.json { render :json => @dogs }
    end
  end

  # GET /dogs/1
  # GET /dogs/1.xml
  def show
    @dog = Dog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dog }
      format.json  { render :json => @dog }
    end
  end

  # GET /dogs/new
  # GET /dogs/new.xml
  def new
    @dog = @person.dogs.create

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dog }
      format.json  { render :json => @dog }      
    end
  end

  # GET /dogs/1/edit
  def edit
    @dog = Dog.find(params[:id])
  end

  # POST /dogs
  # POST /dogs.xml
  def create
    @dog = @person.dogs.create(params[:dog])

    respond_to do |format|
      if @dog.save
        flash[:notice] = 'Dog was successfully created.'
        format.html { redirect_to(@dog) }
        format.xml  { render :xml => @dog, :status => :created, :location => @dog }
        format.json  { render :json => @dog.to_json }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dog.errors, :status => :unprocessable_entity }
        format.json  { render :json => @dog.errors }
      end
    end
  end

  # PUT /dogs/1
  # PUT /dogs/1.xml
  def update
    @dog = Dog.find(params[:id])

    respond_to do |format|
      if @dog.update_attributes(params[:dog])
        flash[:notice] = 'Dog was successfully updated.'
        format.html { redirect_to([@person,@dog]) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dog.errors, :status => :unprocessable_entity }
        format.json  { render :json => @dog.errors }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.xml
  def destroy
    @dog = Dog.find(params[:id])
    @dog.destroy

    respond_to do |format|
      format.html { redirect_to(person_dogs_url(@person)) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  private
  
  def find_person
    @person = Person.find(params[:person_id])
  end
  
end
