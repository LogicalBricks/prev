class SociosController < ApplicationController
  before_action :set_socio, only: [:edit, :update, :destroy]

  # GET /socios
  # GET /socios.json
  def index
    @socios = Socio.para_listar
  end

  # GET /socios/1
  # GET /socios/1.json
  def show
    @socio = Socio.includes(apartados: [:rubro, :prevision]).find(params[:id])
  end

  # GET /socios/new
  def new
    @socio = Socio.new
    @socio.build_usuario
  end

  # GET /socios/1/edit
  def edit
  end

  # POST /socios
  # POST /socios.json
  def create
    @socio = Socio.new(socio_params)

    respond_to do |format|
      if @socio.save
        format.html { redirect_to @socio, notice: 'Socio guardado correctamente.' }
        format.json { render :show, status: :created, location: @socio }
      else
        format.html { render :new }
        format.json { render json: @socio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /socios/1
  # PATCH/PUT /socios/1.json
  def update
    respond_to do |format|
      if @socio.update(socio_params)
        format.html { redirect_to @socio, notice: 'Socio actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @socio }
      else
        format.html { render :edit }
        format.json { render json: @socio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /socios/1
  # DELETE /socios/1.json
  def destroy
    @socio.destroy
    respond_to do |format|
      format.html { redirect_to socios_url, notice: 'Socio eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_socio
      @socio = Socio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def socio_params
      params.require(:socio).permit(
        :nombre,
        usuario_attributes: [:email, :password, :password_confirmation]
      )
    end
end
