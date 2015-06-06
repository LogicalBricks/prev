class ApartadosController < ApplicationController
  before_action :set_apartado, only: [:show, :edit, :update, :destroy]

  # GET /apartados
  # GET /apartados.json
  def index
    @apartados = Apartado.all
  end

  # GET /apartados/1
  # GET /apartados/1.json
  def show
  end

  # GET /apartados/new
  def new
    @apartado = Apartado.new
  end

  # GET /apartados/1/edit
  def edit
  end

  # POST /apartados
  # POST /apartados.json
  def create
    @apartado = Apartado.new(apartado_params)

    respond_to do |format|
      if @apartado.save
        format.html { redirect_to @apartado, notice: 'Apartado was successfully created.' }
        format.json { render :show, status: :created, location: @apartado }
      else
        format.html { render :new }
        format.json { render json: @apartado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartados/1
  # PATCH/PUT /apartados/1.json
  def update
    respond_to do |format|
      if @apartado.update(apartado_params)
        format.html { redirect_to @apartado, notice: 'Apartado was successfully updated.' }
        format.json { render :show, status: :ok, location: @apartado }
      else
        format.html { render :edit }
        format.json { render json: @apartado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartados/1
  # DELETE /apartados/1.json
  def destroy
    @apartado.destroy
    respond_to do |format|
      format.html { redirect_to apartados_url, notice: 'Apartado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartado
      @apartado = Apartado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartado_params
      params.require(:apartado).permit(:monto_maximo, :rubro_id, :prevision_id)
    end
end
