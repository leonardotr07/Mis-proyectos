using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using WearDropWA.OrdenCompraWS;
using WearDropWA.PackageAlmacen;
using WearDropWA.PackagePrendas;

namespace WearDropWA
{
    public partial class AnnadirLineaDeLaCompra : System.Web.UI.Page
    {
        private string Modo => Session["ModoLinea"]?.ToString() ?? "nuevo";
        private OrdenCompraWS.lineaLoteCompra LineaSeleccionada =>
            Session["LineaSeleccionada"] as OrdenCompraWS.lineaLoteCompra;
        private int? IndiceEditar => Session["IndiceLineaEditar"] as int?;

        // 🔹 LISTA PRINCIPAL (desde sesión) - SERVICIO WEB REAL
        private List<OrdenCompraWS.lineaLoteCompra> LineasOrden
        {
            get
            {
                if (Session["LineasOrdenCompra"] == null)
                    Session["LineasOrdenCompra"] = new List<OrdenCompraWS.lineaLoteCompra>();
                return (List<OrdenCompraWS.lineaLoteCompra>)Session["LineasOrdenCompra"];
            }
            set { Session["LineasOrdenCompra"] = value; }
        }

        // 🔹 Propiedades para mantener estado
        private int IdPrendaSeleccionada
        {
            get { return Convert.ToInt32(Session["IdPrendaSeleccionada"] ?? "0"); }
            set { Session["IdPrendaSeleccionada"] = value; }
        }

        private string NombrePrendaSeleccionada
        {
            get { return Session["NombrePrendaSeleccionada"]?.ToString() ?? ""; }
            set { Session["NombrePrendaSeleccionada"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // 🔹 SOLO PARA DEBUG - ELIMINAR DESPUÉS
                ProbarConexionServicios();

                ConfigurarModo();
                CargarTiposDePrenda();

                if (Modo != "nuevo" && LineaSeleccionada != null)
                {
                    CargarDatosLineaExistente();
                }
                else
                {
                    // Inicializar para modo nuevo
                    btnSeleccionarPrenda.Enabled = false;
                    ScriptManager.RegisterStartupScript(this, GetType(), "limpiarInfoPrendaNuevo",
                    @"
                var infoContainer = document.getElementById('infoPrendaEncontrada');
                if (infoContainer) infoContainer.remove();
                ", true);


                }
            }

            // 🔹 INICIALIZAR BOTONES DE TALLA EN CADA CARGA
            ScriptManager.RegisterStartupScript(this, GetType(), "inicializarTallas",
                "setTimeout(function() { inicializarBotonesTalla(); }, 100);", true);
        }
        private void ConfigurarModo()
        {
            switch (Modo)
            {
                case "ver":
                    Page.Title = "Ver Línea de Compra";
                    btnAnadirLinea.Visible = false;
                    DeshabilitarControles();
                    // 🔹 EN MODO VER, NO IMPORTA SI NO ENCONTRÓ EL TIPO
                    break;

                case "modificar":
                    Page.Title = "Modificar Línea de Compra";
                    btnAnadirLinea.Text = "Actualizar Línea";
                    // 🔹 EN MODO MODIFICAR, EL USUARIO PUEDE CORREGIR EL TIPO SI ES NECESARIO
                    break;

                case "nuevo":
                default:
                    Page.Title = "Añadir Línea de Compra";
                    btnAnadirLinea.Text = "Añadir Línea";
                    break;
            }
        }

        private void DeshabilitarControles()
        {
            ddlTipoPrenda.Enabled = false;
            btnSeleccionarPrenda.Enabled = false;
            txtIDLote.Enabled = false;
            txtPrecioLote.Enabled = false;
            txtCantidadComprada.Enabled = false;

            // 🔹 CORRECCIÓN: Deshabilitar también el botón de seleccionar lote
            btnAbrirModalLote.Enabled = false;

            // Deshabilitar botones de tallas mediante script
            ScriptManager.RegisterStartupScript(this, GetType(), "deshabilitarTallas",
                "document.querySelectorAll('.size-btn').forEach(btn => btn.style.pointerEvents = 'none');", true);
        }

        private void CargarDatosLineaExistente()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🚀 CARGANDO LÍNEA EXISTENTE - ID: {LineaSeleccionada.idPrenda}");

                // 🔹 1. CARGAR DATOS BÁSICOS (SIEMPRE DISPONIBLES)
                IdPrendaSeleccionada = LineaSeleccionada.idPrenda;

                // 🔹 CORRECCIÓN: Mostrar SOLO el ID del lote, no la descripción
                if (LineaSeleccionada.lote != null && LineaSeleccionada.lote.idLote > 0)
                {
                    int idLote = LineaSeleccionada.lote.idLote;
                    txtIDLote.Text = idLote.ToString(); // Solo el ID
                    hdnIdLote.Value = idLote.ToString();
                    System.Diagnostics.Debug.WriteLine($"✅ Lote cargado - ID: {idLote}");
                }

                txtPrecioLote.Text = LineaSeleccionada.precioLote.ToString("F2");
                txtCantidadComprada.Text = LineaSeleccionada.cantidad.ToString();

                // 🔹 2. CARGAR TALLA
                string tallaString = ConvertirTallaAString(LineaSeleccionada.talla);
                hdnTallaSeleccionada.Value = tallaString;

                // 🔹 3. BUSCAR INFORMACIÓN DE PRENDA
                var infoPrenda = BuscarInfoPrendaEficiente(LineaSeleccionada.idPrenda);

                // 🔹 ELIMINADO: La sección que mostraba descripción del lote
                // Ya no buscamos información del lote para mostrar descripción

                if (infoPrenda.Tipo != "Desconocido")
                {
                    ddlTipoPrenda.SelectedValue = infoPrenda.Tipo;
                    txtNombrePrenda.Text = infoPrenda.Nombre;
                    NombrePrendaSeleccionada = infoPrenda.Nombre;
                    MostrarInfoPrendaEncontrada(infoPrenda);
                    System.Diagnostics.Debug.WriteLine($"✅ INFORMACIÓN DE PRENDA CARGADA: {infoPrenda.Tipo} - {infoPrenda.Nombre}");
                }
                else
                {
                    txtNombrePrenda.Text = $"Prenda ID: {LineaSeleccionada.idPrenda}";
                    MostrarMensaje($"Información limitada: No se pudo cargar detalles completos de la prenda", "info");
                    System.Diagnostics.Debug.WriteLine($"⚠️ MODO FALLBACK - Información básica mostrada");
                }

                btnSeleccionarPrenda.Enabled = (Modo == "nuevo");

                if (!string.IsNullOrEmpty(tallaString))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "seleccionarTalla",
                        $"setTimeout(function() {{ seleccionarTallaExistente('{tallaString}'); }}, 300);", true);
                }

                System.Diagnostics.Debug.WriteLine($"🏁 CARGA COMPLETADA - Modo: {Modo}");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR CRÍTICO: {ex.Message}");
                txtNombrePrenda.Text = $"Prenda ID: {LineaSeleccionada.idPrenda}";
                MostrarMensaje($"Se cargaron los datos básicos. Error: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO PARA CONVERTIR TALLA ENUM A STRING
        private string ConvertirTallaAString(OrdenCompraWS.talla tallaEnum)
        {
            // 🔹 CORRECCIÓN: El enum no es nullable en tu modelo
            switch (tallaEnum)
            {
                case OrdenCompraWS.talla.XS: return "XS";
                case OrdenCompraWS.talla.S: return "S";
                case OrdenCompraWS.talla.M: return "M";
                case OrdenCompraWS.talla.L: return "L";
                case OrdenCompraWS.talla.XL: return "XL";
                case OrdenCompraWS.talla.XXL: return "XXL";
                default: return "M";
            }
        }

        // 🔹 MÉTODO PARA CONVERTIR STRING A TALLA ENUM
        private OrdenCompraWS.talla ConvertirStringATalla(string tallaString)
        {
            switch (tallaString?.ToUpper())
            {
                case "XS": return OrdenCompraWS.talla.XS;
                case "S": return OrdenCompraWS.talla.S;
                case "M": return OrdenCompraWS.talla.M;
                case "L": return OrdenCompraWS.talla.L;
                case "XL": return OrdenCompraWS.talla.XL;
                case "XXL": return OrdenCompraWS.talla.XXL;
                default: return OrdenCompraWS.talla.M;
            }
        }

        // 🔹 MÉTODO MEJORADO: BÚSQUEDA EXHAUSTIVA EN TODOS LOS TIPOS DE PRENDA
        // 🔹 MÉTODO MEJORADO: BÚSQUEDA EXHAUSTIVA CON MEJOR LOGGING
        private PrendaInfo BuscarInfoPrenda(int idPrenda)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔍 INICIANDO BÚSQUEDA EXHAUSTIVA para prenda ID: {idPrenda}");

                // 🔹 LISTA DE TODOS LOS TIPOS DE PRENDA POSIBLES
                string[] tipos = { "Blusa", "Casaca", "Falda", "Gorro", "Pantalon", "Polo", "Vestido" };
                int intentos = 0;
                PrendaInfo resultado = null;

                foreach (string tipo in tipos)
                {
                    intentos++;
                    System.Diagnostics.Debug.WriteLine($"🔄 Intentando tipo {intentos}/7: {tipo}");

                    try
                    {
                        var prenda = BuscarPrendaPorId(idPrenda, tipo);
                        if (prenda != null)
                        {
                            resultado = new PrendaInfo { Tipo = tipo, Nombre = prenda.Nombre };
                            System.Diagnostics.Debug.WriteLine($"🎯 ✅ PRENDA ENCONTRADA en {tipo}: {prenda.Nombre}");
                            break; // 🔹 SALIR DEL BUCLE CUANDO ENCONTREMOS
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"❌ No encontrada en {tipo}");
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"⚠️ Error en tipo {tipo}: {ex.Message}");
                        // 🔹 CONTINUAR CON EL SIGUIENTE TIPO A PESAR DEL ERROR
                        continue;
                    }
                }

                if (resultado != null)
                {
                    System.Diagnostics.Debug.WriteLine($"🏁 BÚSQUEDA EXITOSA: {resultado.Tipo} - {resultado.Nombre}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"💥 BÚSQUEDA FALLIDA: No se encontró la prenda ID {idPrenda} en ningún tipo");

                    // 🔹 INTENTAR UNA BÚSQUEDA DIRECTA EN LA BD COMO ÚLTIMO RECURSO
                    resultado = BusquedaDirectaEnBD(idPrenda);
                }

                return resultado;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR CRÍTICO en búsqueda: {ex.Message}");
                return null;
            }
        }

        // 🔹 MÉTODO CORREGIDO: BUSCAR PRENDA POR ID Y TIPO (BASADO EN TUS MODELOS REALES)
        // 🔹 MÉTODO SIMPLIFICADO: BUSCAR PRENDA POR ID - SIEMPRE ACTIVA
        private PrendaViewModel BuscarPrendaPorId(int idPrenda, string tipoPrenda)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"  🔍 Buscando {tipoPrenda} con ID {idPrenda}...");

                switch (tipoPrenda)
                {
                    case "Blusa":
                        var blusaWS = new PackagePrendas.BlusaWSClient();
                        var blusa = blusaWS.obtenerBlusaPorId(idPrenda);
                        if (blusa != null && blusa.idPrenda > 0 && !string.IsNullOrEmpty(blusa.nombre))
                        {
                            System.Diagnostics.Debug.WriteLine($"    ✅ Blusa encontrada: {blusa.nombre}");
                            return new PrendaViewModel
                            {
                                Id = blusa.idPrenda,
                                Nombre = blusa.nombre,
                                Color = blusa.color ?? "",
                                Material = ObtenerMaterialComoString(blusa.material),
                                PrecioMayor = blusa.precioMayor,
                                Tipo = "Blusa"
                            };
                        }
                        break;

                    case "Casaca":
                        var casacaWS = new PackagePrendas.CasacaWSClient();
                        var casaca = casacaWS.obtenerCasacaPorId(idPrenda);
                        if (casaca != null && casaca.idPrenda > 0 && !string.IsNullOrEmpty(casaca.nombre))
                        {
                            System.Diagnostics.Debug.WriteLine($"    ✅ Casaca encontrada: {casaca.nombre}");
                            return new PrendaViewModel
                            {
                                Id = casaca.idPrenda,
                                Nombre = casaca.nombre,
                                Color = casaca.color ?? "",
                                Material = ObtenerMaterialComoString(casaca.material),
                                PrecioMayor = casaca.precioMayor,
                                Tipo = "Casaca"
                            };
                        }
                        break;

                    case "Falda":
                        var faldaWS = new PackagePrendas.FaldaWSClient();
                        var falda = faldaWS.obtenerFaldaPorId(idPrenda);
                        if (falda != null && falda.idPrenda > 0 && !string.IsNullOrEmpty(falda.nombre))
                        {
                            System.Diagnostics.Debug.WriteLine($"    ✅ Falda encontrada: {falda.nombre}");
                            return new PrendaViewModel
                            {
                                Id = falda.idPrenda,
                                Nombre = falda.nombre,
                                Color = falda.color ?? "",
                                Material = ObtenerMaterialComoString(falda.material),
                                PrecioMayor = falda.precioMayor,
                                Tipo = "Falda"
                            };
                        }
                        break;

                    case "Gorro":
                        var gorroWS = new PackagePrendas.GorroWSClient();
                        var gorro = gorroWS.obtenerGorroPorId(idPrenda);
                        if (gorro != null && gorro.idPrenda > 0 && !string.IsNullOrEmpty(gorro.nombre))
                        {
                            System.Diagnostics.Debug.WriteLine($"    ✅ Gorro encontrado: {gorro.nombre}");
                            return new PrendaViewModel
                            {
                                Id = gorro.idPrenda,
                                Nombre = gorro.nombre,
                                Color = gorro.color ?? "",
                                Material = ObtenerMaterialComoString(gorro.material),
                                PrecioMayor = gorro.precioMayor,
                                Tipo = "Gorro"
                            };
                        }
                        break;

                    case "Pantalon":
                        var pantalonWS = new PackagePrendas.PantalonWSClient();
                        var pantalon = pantalonWS.obtenerPantalonPorId(idPrenda);
                        if (pantalon != null && pantalon.idPrenda > 0 && !string.IsNullOrEmpty(pantalon.nombre))
                        {
                            System.Diagnostics.Debug.WriteLine($"    ✅ Pantalón encontrado: {pantalon.nombre}");
                            return new PrendaViewModel
                            {
                                Id = pantalon.idPrenda,
                                Nombre = pantalon.nombre,
                                Color = pantalon.color ?? "",
                                Material = ObtenerMaterialComoString(pantalon.material),
                                PrecioMayor = pantalon.precioMayor,
                                Tipo = "Pantalon"
                            };
                        }
                        break;

                    case "Polo":
                        var poloWS = new PackagePrendas.PoloWSClient();
                        var polo = poloWS.obtenerPoloPorId(idPrenda);
                        if (polo != null && polo.idPrenda > 0 && !string.IsNullOrEmpty(polo.nombre))
                        {
                            System.Diagnostics.Debug.WriteLine($"    ✅ Polo encontrado: {polo.nombre}");
                            return new PrendaViewModel
                            {
                                Id = polo.idPrenda,
                                Nombre = polo.nombre,
                                Color = polo.color ?? "",
                                Material = ObtenerMaterialComoString(polo.material),
                                PrecioMayor = polo.precioMayor,
                                Tipo = "Polo"
                            };
                        }
                        break;

                    case "Vestido":
                        var vestidoWS = new PackagePrendas.VestidoWSClient();
                        var vestido = vestidoWS.obtenerVestidoPorId(idPrenda);
                        if (vestido != null && vestido.idPrenda > 0 && !string.IsNullOrEmpty(vestido.nombre))
                        {
                            System.Diagnostics.Debug.WriteLine($"    ✅ Vestido encontrado: {vestido.nombre}");
                            return new PrendaViewModel
                            {
                                Id = vestido.idPrenda,
                                Nombre = vestido.nombre,
                                Color = vestido.color ?? "",
                                Material = ObtenerMaterialComoString(vestido.material),
                                PrecioMayor = vestido.precioMayor,
                                Tipo = "Vestido"
                            };
                        }
                        break;

                    default:
                        System.Diagnostics.Debug.WriteLine($"    ❌ Tipo desconocido: {tipoPrenda}");
                        break;
                }

                System.Diagnostics.Debug.WriteLine($"    ❌ No encontrado en {tipoPrenda} o datos incompletos");
                return null;
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                System.Diagnostics.Debug.WriteLine($"    💥 FAULT EXCEPTION en {tipoPrenda}: {faultEx.Message}");
                return null;
            }
            catch (System.ServiceModel.CommunicationException commEx)
            {
                System.Diagnostics.Debug.WriteLine($"    💥 COMMUNICATION EXCEPTION en {tipoPrenda}: {commEx.Message}");
                return null;
            }
            catch (TimeoutException timeoutEx)
            {
                System.Diagnostics.Debug.WriteLine($"    💥 TIMEOUT EXCEPTION en {tipoPrenda}: {timeoutEx.Message}");
                return null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"    💥 ERROR GENERAL en búsqueda de {tipoPrenda}: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"    💥 Tipo de excepción: {ex.GetType()}");
                return null;
            }
        }

        // 🔹 MÉTODO CORREGIDO: VALIDAR PRENDA - SIEMPRE ACTIVA
        private bool EsPrendaValida(dynamic prenda)
        {
            try
            {
                if (prenda == null)
                {
                    System.Diagnostics.Debug.WriteLine("      ❌ Prenda es NULL");
                    return false;
                }

                // 🔹 VERIFICACIONES BÁSICAS
                bool tieneId = prenda.idPrenda > 0;
                bool tieneNombre = !string.IsNullOrEmpty(prenda.nombre?.ToString());

                // 🔹 CLAVE: SIEMPRE ASUMIR QUE LA PRENDA ESTÁ ACTIVA
                // porque el dropdown solo muestra prendas activas
                bool estaActivo = true;

                System.Diagnostics.Debug.WriteLine($"      📊 Validación - ID: {tieneId}, Nombre: {tieneNombre}, Activo: {estaActivo} (ASUMIDO)");

                return tieneId && tieneNombre && estaActivo;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"      💥 Error en validación de prenda: {ex.Message}");
                return false;
            }
        }

        // 🔹 MÉTODO MODIFICADO: Añadir/Actualizar línea - CORREGIDO
        protected void btnAnadirLinea_Click(object sender, EventArgs e)
        {
            if (!ValidarCampos())
                return;

            try
            {
                System.Diagnostics.Debug.WriteLine("🎯 INICIANDO btnAnadirLinea_Click");

                // 🔹 CORRECCIÓN: Extraer el ID del lote correctamente del hidden field
                int idLote = 0;
                if (!int.TryParse(hdnIdLote.Value, out idLote) && !int.TryParse(txtIDLote.Text.Trim(), out idLote))
                {
                    MostrarMensaje("Error: ID de lote inválido.", "error");
                    return;
                }

                // 🔹 VERIFICAR QUE TENEMOS ACCESO A LA LISTA
                if (LineasOrden == null)
                {
                    System.Diagnostics.Debug.WriteLine("❌ ERROR: LineasOrden es NULL - Inicializando...");
                    LineasOrden = new List<OrdenCompraWS.lineaLoteCompra>();
                }

                System.Diagnostics.Debug.WriteLine($"Líneas antes de agregar: {LineasOrden.Count}");
                System.Diagnostics.Debug.WriteLine($"ID Lote a guardar: {idLote}");

                // 🔹 CREAR OBJETO LOTE CORRECTAMENTE
                var lote = new OrdenCompraWS.lote
                {
                    idLote = idLote,
                    activo = true
                };

                // 🔹 CREAR LINEALOTECOMPRA
                var lineaLote = new OrdenCompraWS.lineaLoteCompra
                {
                    idPrenda = IdPrendaSeleccionada,
                    cantidad = int.Parse(txtCantidadComprada.Text),
                    talla = ConvertirStringATalla(hdnTallaSeleccionada.Value),
                    lote = lote, // 🔹 ESTO ES CLAVE: Asignar el objeto lote completo
                    precioLote = double.Parse(txtPrecioLote.Text),
                    activo = true,
                    numLinea = LineasOrden.Count + 1
                };

                // 🔹 Asegurar que la talla está especificada
                lineaLote.tallaSpecified = true;

                System.Diagnostics.Debug.WriteLine($"Nueva línea - Prenda: {lineaLote.idPrenda}, Cantidad: {lineaLote.cantidad}, Precio: {lineaLote.precioLote}, Lote ID: {lineaLote.lote.idLote}");

                if (Modo == "modificar" && IndiceEditar.HasValue)
                {
                    // 🔹 ACTUALIZAR LÍNEA EXISTENTE
                    if (IndiceEditar.Value < LineasOrden.Count)
                    {
                        lineaLote.numLinea = LineasOrden[IndiceEditar.Value].numLinea;
                        LineasOrden[IndiceEditar.Value] = lineaLote;
                        System.Diagnostics.Debug.WriteLine($"✅ Línea {IndiceEditar.Value} actualizada con Lote ID: {lineaLote.lote.idLote}");
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"❌ Índice inválido: {IndiceEditar.Value}");
                        MostrarMensaje("Error: No se pudo encontrar la línea a modificar.", "error");
                        return;
                    }
                }
                else
                {
                    // 🔹 AÑADIR NUEVA LÍNEA
                    LineasOrden.Add(lineaLote);
                    System.Diagnostics.Debug.WriteLine($"✅ Nueva línea agregada. Total: {LineasOrden.Count}");
                }

                // 🔹 VERIFICAR QUE EL LOTE SE GUARDÓ CORRECTAMENTE
                System.Diagnostics.Debug.WriteLine($"=== VERIFICACIÓN LOTE GUARDADO ===");
                foreach (var linea in LineasOrden)
                {
                    System.Diagnostics.Debug.WriteLine($"Línea - Prenda: {linea.idPrenda}, Lote ID: {linea.lote?.idLote}");
                }

                // 🔹 GUARDAR LA BANDERA ANTES DE LIMPIAR - ESTO ES CLAVE
                Session["VieneDeModificarLinea"] = true;

                // 🔹 VERIFICAR QUE LAS LÍNEAS SE GUARDARON EN SESIÓN
                System.Diagnostics.Debug.WriteLine($"Líneas después de agregar: {LineasOrden.Count}");

                // 🔹 DIAGNÓSTICO ANTES DE REDIRIGIR
                DiagnosticarSesionAntesDeRedirigir();

                MostrarMensaje(Modo == "modificar" ? "Línea actualizada correctamente." : "Línea añadida correctamente.", "exito");

                // 🔹 LIMPIAR SOLO LAS SESIONES TEMPORALES DE LA LÍNEA ACTUAL
                Session.Remove("LineaSeleccionada");
                Session.Remove("ModoLinea");
                Session.Remove("IndiceLineaEditar");
                Session.Remove("IdPrendaSeleccionada");
                Session.Remove("NombrePrendaSeleccionada");
                Session.Remove("TipoPrendaSeleccionada");

                System.Diagnostics.Debug.WriteLine("🔄 Redirigiendo a RegistrarOrdenCompra.aspx...");

                // 🔹 REDIRIGIR CON CONFIRMACIÓN
                Response.Redirect("~/RegistrarOrdenCompra.aspx");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en btnAnadirLinea_Click: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack: {ex.StackTrace}");
                MostrarMensaje($"Error al guardar línea: {ex.Message}", "error");
            }
        }

        // 🔹 AÑADIR MÉTODO DE DIAGNÓSTICO ANTES DE REDIRIGIR
        private void DiagnosticarSesionAntesDeRedirigir()
        {
            System.Diagnostics.Debug.WriteLine("=== DIAGNÓSTICO ANTES DE REDIRIGIR ===");
            System.Diagnostics.Debug.WriteLine($"LineasOrden en sesión: {LineasOrden.Count}");
            System.Diagnostics.Debug.WriteLine($"VieneDeModificarLinea: {Session["VieneDeModificarLinea"]}");

            var lineasEnSesion = Session["LineasOrdenCompra"] as List<OrdenCompraWS.lineaLoteCompra>;
            System.Diagnostics.Debug.WriteLine($"Session['LineasOrdenCompra']: {(lineasEnSesion != null ? lineasEnSesion.Count + " elementos" : "NULL")}");
            System.Diagnostics.Debug.WriteLine("=====================================");
        }

        private bool ValidarCampos()
        {
            if (IdPrendaSeleccionada == 0 ||
                string.IsNullOrEmpty(txtIDLote.Text) ||
                string.IsNullOrEmpty(txtPrecioLote.Text) ||
                string.IsNullOrEmpty(hdnTallaSeleccionada.Value) ||
                string.IsNullOrEmpty(txtCantidadComprada.Text))
            {
                MostrarMensaje("Por favor, complete todos los campos requeridos (*) antes de guardar.", "error");
                return false;
            }

            // 🔹 CAMBIO: Ahora txtIDLote contiene directamente el ID
            if (!int.TryParse(txtIDLote.Text, out int idLote) || idLote <= 0)
            {
                MostrarMensaje("Por favor, seleccione un lote válido.", "error");
                return false;
            }
            // 🔹 ACTUALIZAR el hidden field también
            hdnIdLote.Value = idLote.ToString();

            if (!int.TryParse(txtCantidadComprada.Text, out int cantidad) || cantidad <= 0)
            {
                MostrarMensaje("Por favor, ingrese una cantidad válida mayor a cero.", "error");
                return false;
            }

            if (!decimal.TryParse(txtPrecioLote.Text, out decimal precio) || precio <= 0)
            {
                MostrarMensaje("Por favor, ingrese un precio válido mayor a cero.", "error");
                return false;
            }

            return true;
        }
        // 🔹 MÉTODO CORREGIDO: Limpiar solo lo necesario
        private void LimpiarSesionesTemporales()
        {
            // 🔹 LIMPIAR SOLO LOS DATOS DE LA LÍNEA ACTUAL, NO TODA LA LISTA
            Session.Remove("LineaSeleccionada");
            Session.Remove("ModoLinea");
            Session.Remove("IndiceLineaEditar");
            Session.Remove("IdPrendaSeleccionada");
            Session.Remove("NombrePrendaSeleccionada");
            Session.Remove("TipoPrendaSeleccionada");

            // 🔹 NO LIMPIAR LineasOrden - mantener las modificaciones
            System.Diagnostics.Debug.WriteLine("✅ Sesiones temporales limpiadas, LineasOrden preservada");
        }

        // 🔹 MÉTODO PARA MOSTRAR MENSAJES
        private void MostrarMensaje(string mensaje, string tipo = "info")
        {
            if (lblMensaje != null)
            {
                lblMensaje.Text = mensaje;
                lblMensaje.CssClass = $"mensaje-alerta mensaje-{tipo}";
                lblMensaje.Visible = true;

                ScriptManager.RegisterStartupScript(this, GetType(), "ocultarMensaje",
                    $"setTimeout(function() {{ document.getElementById('{lblMensaje.ClientID}').style.display = 'none'; }}, 5000);", true);
            }

            string mensajeLimpio = mensaje.Replace("'", "\\'").Replace("\n", "\\n");
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{mensajeLimpio}');", true);
        }

        // 🔹 CARGAR TIPOS DE PRENDA
        private void CargarTiposDePrenda()
        {
            ddlTipoPrenda.Items.Clear();
            ddlTipoPrenda.Items.Add(new ListItem("Seleccionar tipo de prenda", ""));
            ddlTipoPrenda.Items.Add(new ListItem("Blusa", "Blusa"));
            ddlTipoPrenda.Items.Add(new ListItem("Casaca", "Casaca"));
            ddlTipoPrenda.Items.Add(new ListItem("Falda", "Falda"));
            ddlTipoPrenda.Items.Add(new ListItem("Gorro", "Gorro"));
            ddlTipoPrenda.Items.Add(new ListItem("Pantalon", "Pantalon"));
            ddlTipoPrenda.Items.Add(new ListItem("Polo", "Polo"));
            ddlTipoPrenda.Items.Add(new ListItem("Vestido", "Vestido"));
        }

        // 🔹 EVENTO CAMBIO EN DROPDOWN
        protected void ddlTipoPrenda_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlTipoPrenda.SelectedValue;
            bool tieneValorValido = !string.IsNullOrEmpty(selectedValue) && selectedValue != "";

            btnSeleccionarPrenda.Enabled = tieneValorValido;

            // 🔹 LIMPIAR SELECCIÓN ANTERIOR Y SESIÓN
            txtNombrePrenda.Text = "";
            hdnIdPrenda.Value = "";
            IdPrendaSeleccionada = 0;
            NombrePrendaSeleccionada = "";
            Session.Remove("TipoPrendaSeleccionada"); // 🔹 LIMPIAR TIPO DE SESIÓN

            System.Diagnostics.Debug.WriteLine($"🔄 Dropdown cambiado: {selectedValue}, Sesión limpiada");

            ScriptManager.RegisterStartupScript(this, GetType(), "debugDropDown",
                $"console.log('Dropdown seleccionado: {selectedValue}, Botón habilitado: {tieneValorValido}');", true);
        }
        // 🔹 ABRIR MODAL PARA SELECCIONAR PRENDA
        protected void btnSeleccionarPrenda_Click(object sender, EventArgs e)
        {
            string tipoPrenda = ddlTipoPrenda.SelectedValue;

            if (string.IsNullOrEmpty(tipoPrenda))
            {
                MostrarMensaje("Por favor, seleccione un tipo de prenda válido.", "error");
                return;
            }

            try
            {
                // 1. Cargar datos en el GridView
                CargarPrendasEnModal(tipoPrenda);
                lblTipoPrendaModal.Text = tipoPrenda;

                // 2. Actualizar el UpdatePanel para reflejar los cambios
                UpdatePanel1.Update();

                // 3. Mostrar el modal DESPUÉS de actualizar el UpdatePanel
                string script = @"
            console.log('Mostrando modal después de actualizar UpdatePanel');
            var modal = new bootstrap.Modal(document.getElementById('modalSeleccionarPrenda'));
            modal.show();
        ";

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModal", script, true);
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al abrir el selector de prendas: {ex.Message}", "error");
            }
        }

        // 🔹 CARGAR PRENDAS EN MODAL - MÉTODOS CORREGIDOS BASADOS EN TUS MODELOS
        private void CargarPrendasEnModal(string tipoPrenda)
        {
            try
            {
                List<PrendaViewModel> prendas = new List<PrendaViewModel>();

                switch (tipoPrenda)
                {
                    case "Blusa":
                        prendas = ObtenerBlusasReal();
                        break;
                    case "Casaca":
                        prendas = ObtenerCasacasReal();
                        break;
                    case "Falda":
                        prendas = ObtenerFaldasReal();
                        break;
                    case "Gorro":
                        prendas = ObtenerGorrosReal();
                        break;
                    case "Pantalon":
                        prendas = ObtenerPantalonesReal();
                        break;
                    case "Polo":
                        prendas = ObtenerPolosReal();
                        break;
                    case "Vestido":
                        prendas = ObtenerVestidosReal();
                        break;
                    default:
                        MostrarMensaje("Tipo de prenda no válido.", "error");
                        return;
                }

                if (prendas.Count == 0)
                {
                    MostrarMensaje($"No se encontraron prendas de tipo {tipoPrenda} activas.", "info");
                }

                // Asignar datos al GridView
                gvPrendas.DataSource = prendas;
                gvPrendas.DataBind();

            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar prendas: {ex.Message}", "error");
            }
        }

        /// 🔹 EVENTO SELECCIONAR PRENDA DESDE GRIDVIEW - GUARDAR TIPO
        protected void gvPrendas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                string[] argumentos = e.CommandArgument.ToString().Split('|');
                if (argumentos.Length >= 2)
                {
                    IdPrendaSeleccionada = int.Parse(argumentos[0]);
                    NombrePrendaSeleccionada = argumentos[1];

                    // 🔹 CLAVE: Guardar el tipo de prenda actual del dropdown
                    string tipoPrendaActual = ddlTipoPrenda.SelectedValue;
                    Session["TipoPrendaSeleccionada"] = tipoPrendaActual;

                    txtNombrePrenda.Text = NombrePrendaSeleccionada;
                    hdnIdPrenda.Value = IdPrendaSeleccionada.ToString();

                    System.Diagnostics.Debug.WriteLine($"✅ Prenda seleccionada - ID: {IdPrendaSeleccionada}, Nombre: {NombrePrendaSeleccionada}, Tipo: {tipoPrendaActual}");

                    // Cerrar el modal
                    string cerrarScript = @"
                console.log('Cerrando modal completamente...');
                var modalElement = document.getElementById('modalSeleccionarPrenda');
                if (modalElement) {
                    var modal = bootstrap.Modal.getInstance(modalElement);
                    if (modal) {
                        modal.hide();
                    } else {
                        var newModal = new bootstrap.Modal(modalElement);
                        newModal.hide();
                    }
                }
                setTimeout(function() {
                    var backdrops = document.querySelectorAll('.modal-backdrop');
                    backdrops.forEach(function(backdrop) {
                        backdrop.remove();
                    });
                    document.body.classList.remove('modal-open');
                    document.body.style.paddingRight = '';
                    document.body.style.overflow = '';
                }, 150);
            ";

                    ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", cerrarScript, true);

                    MostrarMensaje($"Prenda seleccionada: {NombrePrendaSeleccionada}", "exito");
                    UpdatePanel1.Update();
                }
            }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            LimpiarSesionesTemporales();
            Response.Redirect("~/RegistrarOrdenCompra.aspx");
        }

        #region MÉTODOS PARA OBTENER PRENDAS REALES - CORREGIDOS
        private List<PrendaViewModel> ObtenerBlusasReal()
        {
            try
            {
                var blusaWS = new PackagePrendas.BlusaWSClient();
                var blusas = blusaWS.listarBlusas();

                return blusas.Where(b => b != null && b.activo)
                             .Select(b => new PrendaViewModel
                             {
                                 Id = b.idPrenda,
                                 Nombre = b.nombre,
                                 Color = b.color ?? "",
                                 Material = ObtenerMaterialComoString(b.material),
                                 PrecioMayor = b.precioMayor,
                                 Tipo = "Blusa"
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar blusas: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerCasacasReal()
        {
            try
            {
                var casacaWS = new PackagePrendas.CasacaWSClient();
                var casacas = casacaWS.listarCasacas();

                return casacas.Where(c => c != null && c.activo)
                             .Select(c => new PrendaViewModel
                             {
                                 Id = c.idPrenda,
                                 Nombre = c.nombre,
                                 Color = c.color ?? "",
                                 Material = ObtenerMaterialComoString(c.material),
                                 PrecioMayor = c.precioMayor,
                                 Tipo = "Casaca"
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar casacas: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerFaldasReal()
        {
            try
            {
                var faldaWS = new PackagePrendas.FaldaWSClient();
                var faldas = faldaWS.listarFaldas();

                return faldas.Where(f => f != null && f.activo)
                             .Select(f => new PrendaViewModel
                             {
                                 Id = f.idPrenda,
                                 Nombre = f.nombre,
                                 Color = f.color ?? "",
                                 Material = ObtenerMaterialComoString(f.material),
                                 PrecioMayor = f.precioMayor,
                                 Tipo = "Falda"
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar faldas: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerGorrosReal()
        {
            try
            {
                var gorroWS = new PackagePrendas.GorroWSClient();
                var gorros = gorroWS.listarGorros();

                return gorros.Where(g => g != null && g.activo)
                             .Select(g => new PrendaViewModel
                             {
                                 Id = g.idPrenda,
                                 Nombre = g.nombre,
                                 Color = g.color ?? "",
                                 Material = ObtenerMaterialComoString(g.material),
                                 PrecioMayor = g.precioMayor,
                                 Tipo = "Gorro"
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar gorros: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerPantalonesReal()
        {
            try
            {
                var pantalonWS = new PackagePrendas.PantalonWSClient();
                var pantalones = pantalonWS.listarPantalones();

                return pantalones.Where(p => p != null && p.activo)
                                 .Select(p => new PrendaViewModel
                                 {
                                     Id = p.idPrenda,
                                     Nombre = p.nombre,
                                     Color = p.color ?? "",
                                     Material = ObtenerMaterialComoString(p.material),
                                     PrecioMayor = p.precioMayor,
                                     Tipo = "Pantalon"
                                 }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar pantalones: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerPolosReal()
        {
            try
            {
                var poloWS = new PackagePrendas.PoloWSClient();
                var polos = poloWS.listarPolos();

                return polos.Where(p => p != null && p.activo)
                            .Select(p => new PrendaViewModel
                            {
                                Id = p.idPrenda,
                                Nombre = p.nombre,
                                Color = p.color ?? "",
                                Material = ObtenerMaterialComoString(p.material),
                                PrecioMayor = p.precioMayor,
                                Tipo = "Polo"
                            }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar polos: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerVestidosReal()
        {
            try
            {
                var vestidoWS = new PackagePrendas.VestidoWSClient();
                var vestidos = vestidoWS.listarVestidos();

                return vestidos.Where(v => v != null && v.activo)
                               .Select(v => new PrendaViewModel
                               {
                                   Id = v.idPrenda,
                                   Nombre = v.nombre,
                                   Color = v.color ?? "",
                                   Material = ObtenerMaterialComoString(v.material),
                                   PrecioMayor = v.precioMayor,
                                   Tipo = "Vestido"
                               }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar vestidos: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private string ObtenerMaterialComoString(object material)
        {
            if (material == null) return "No especificado";
            try { return material.ToString(); } catch { return "No especificado"; }
        }

        // 🔹 MÉTODO NUEVO: MOSTRAR INFORMACIÓN DE LA PRENDA ENCONTRADA
        // 🔹 MÉTODO NUEVO: MOSTRAR INFORMACIÓN DE LA PRENDA ENCONTRADA - MEJORADO
        private void MostrarInfoPrendaEncontrada(PrendaInfo infoPrenda)
        {
            try
            {
                // 🔹 DETERMINAR TIPO DE MENSAJE SEGÚN EL ORIGEN DE LA INFORMACIÓN
                string tipoMensaje = infoPrenda.Tipo == "Desconocido" ? "advertencia" : "exito";
                string icono = infoPrenda.Tipo == "Desconocido" ? "⚠" : "✅";
                string claseCSS = infoPrenda.Tipo == "Desconocido" ? "prenda-info-advertencia" : "prenda-info-encontrada";

                // 🔹 CREAR MENSAJE INFORMATIVO
                string mensajeInfo = $"{icono} {(infoPrenda.Tipo == "Desconocido" ? "Información básica" : "Prenda encontrada automáticamente")}:\n" +
                                   $"• Tipo: {infoPrenda.Tipo}\n" +
                                   $"• Nombre: {infoPrenda.Nombre}\n" +
                                   $"• ID: {IdPrendaSeleccionada}";

                // 🔹 MOSTRAR EN CONSOLA PARA DEBUG
                System.Diagnostics.Debug.WriteLine(mensajeInfo);

                // 🔹 ACTUALIZAR EL TEXTO DEL DROPDOWN PARA MOSTRAR INFORMACIÓN ADICIONAL
                ScriptManager.RegisterStartupScript(this, GetType(), "actualizarDropdownInfo",
                    $@"
            console.log('Actualizando información visual de la prenda...');
            
            // Agregar información visual al dropdown (solo lectura)
            var dropdown = document.getElementById('{ddlTipoPrenda.ClientID}');
            if (dropdown) {{
                // Crear un elemento de información adicional
                var infoContainer = document.getElementById('infoPrendaEncontrada');
                if (!infoContainer) {{
                    infoContainer = document.createElement('div');
                    infoContainer.id = 'infoPrendaEncontrada';
                    infoContainer.className = '{claseCSS}';
                    infoContainer.innerHTML = '<strong>{icono} {(infoPrenda.Tipo == "Desconocido" ? "Información básica" : "Prenda encontrada")}:</strong> {infoPrenda.Nombre} (Tipo: {infoPrenda.Tipo})';
                    dropdown.parentNode.appendChild(infoContainer);
                }} else {{
                    infoContainer.innerHTML = '<strong>{icono} {(infoPrenda.Tipo == "Desconocido" ? "Información básica" : "Prenda encontrada")}:</strong> {infoPrenda.Nombre} (Tipo: {infoPrenda.Tipo})';
                }}
            }}
            ", true);

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al mostrar información de prenda: {ex.Message}");
            }
        }

        // 🔹 MÉTODO NUEVO: BUSCAR PRENDA EN LAS LÍNEAS DE LA SESIÓN ACTUAL
        private PrendaInfo BuscarPrendaEnLineasSesion(int idPrenda)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔍 Buscando prenda ID {idPrenda} en líneas de sesión...");

                // Buscar en todas las líneas de la orden actual
                foreach (var linea in LineasOrden)
                {
                    if (linea.idPrenda == idPrenda)
                    {
                        System.Diagnostics.Debug.WriteLine($"✅ Prenda encontrada en sesión (ID: {idPrenda})");

                        // 🔹 BUSCAR EL NOMBRE EN LOS SERVICIOS WEB
                        var infoBD = BuscarNombrePrendaEnBD(idPrenda);
                        if (infoBD != null)
                        {
                            return infoBD;
                        }
                        else
                        {
                            // Si no se encuentra en BD, usar información genérica
                            return new PrendaInfo
                            {
                                Tipo = "Desconocido",
                                Nombre = $"Prenda ID: {idPrenda} (En sesión)"
                            };
                        }
                    }
                }

                System.Diagnostics.Debug.WriteLine($"❌ Prenda ID {idPrenda} no encontrada en sesión");
                return null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 Error buscando prenda en sesión: {ex.Message}");
                return null;
            }
        }
        // 🔹 MÉTODO NUEVO: BUSCAR SOLO EL NOMBRE DE LA PRENDA EN BD (MÁS RÁPIDO)
        private PrendaInfo BuscarNombrePrendaEnBD(int idPrenda)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔍 Buscando nombre de prenda ID {idPrenda} en BD...");

                string[] tipos = { "Blusa", "Casaca", "Falda", "Gorro", "Pantalon", "Polo", "Vestido" };

                foreach (string tipo in tipos)
                {
                    try
                    {
                        switch (tipo)
                        {
                            case "Blusa":
                                var blusaWS = new PackagePrendas.BlusaWSClient();
                                var blusa = blusaWS.obtenerBlusaPorId(idPrenda);
                                if (blusa != null && blusa.activo)
                                {
                                    System.Diagnostics.Debug.WriteLine($"✅ Nombre encontrado en BD: {blusa.nombre}");
                                    return new PrendaInfo { Tipo = tipo, Nombre = blusa.nombre };
                                }
                                break;

                            case "Casaca":
                                var casacaWS = new PackagePrendas.CasacaWSClient();
                                var casaca = casacaWS.obtenerCasacaPorId(idPrenda);
                                if (casaca != null && casaca.activo)
                                {
                                    System.Diagnostics.Debug.WriteLine($"✅ Nombre encontrado en BD: {casaca.nombre}");
                                    return new PrendaInfo { Tipo = tipo, Nombre = casaca.nombre };
                                }
                                break;

                            case "Falda":
                                var faldaWS = new PackagePrendas.FaldaWSClient();
                                var falda = faldaWS.obtenerFaldaPorId(idPrenda);
                                if (falda != null && falda.activo)
                                {
                                    System.Diagnostics.Debug.WriteLine($"✅ Nombre encontrado en BD: {falda.nombre}");
                                    return new PrendaInfo { Tipo = tipo, Nombre = falda.nombre };
                                }
                                break;

                            case "Gorro":
                                var gorroWS = new PackagePrendas.GorroWSClient();
                                var gorro = gorroWS.obtenerGorroPorId(idPrenda);
                                if (gorro != null && gorro.activo)
                                {
                                    System.Diagnostics.Debug.WriteLine($"✅ Nombre encontrado en BD: {gorro.nombre}");
                                    return new PrendaInfo { Tipo = tipo, Nombre = gorro.nombre };
                                }
                                break;

                            case "Pantalon":
                                var pantalonWS = new PackagePrendas.PantalonWSClient();
                                var pantalon = pantalonWS.obtenerPantalonPorId(idPrenda);
                                if (pantalon != null && pantalon.activo)
                                {
                                    System.Diagnostics.Debug.WriteLine($"✅ Nombre encontrado en BD: {pantalon.nombre}");
                                    return new PrendaInfo { Tipo = tipo, Nombre = pantalon.nombre };
                                }
                                break;

                            case "Polo":
                                var poloWS = new PackagePrendas.PoloWSClient();
                                var polo = poloWS.obtenerPoloPorId(idPrenda);
                                if (polo != null && polo.activo)
                                {
                                    System.Diagnostics.Debug.WriteLine($"✅ Nombre encontrado en BD: {polo.nombre}");
                                    return new PrendaInfo { Tipo = tipo, Nombre = polo.nombre };
                                }
                                break;

                            case "Vestido":
                                var vestidoWS = new PackagePrendas.VestidoWSClient();
                                var vestido = vestidoWS.obtenerVestidoPorId(idPrenda);
                                if (vestido != null && vestido.activo)
                                {
                                    System.Diagnostics.Debug.WriteLine($"✅ Nombre encontrado en BD: {vestido.nombre}");
                                    return new PrendaInfo { Tipo = tipo, Nombre = vestido.nombre };
                                }
                                break;
                        }
                    }
                    catch (Exception ex)
                    {
                        // Continuar con el siguiente tipo si hay error
                        System.Diagnostics.Debug.WriteLine($"⚠ Error buscando {tipo}: {ex.Message}");
                        continue;
                    }
                }

                System.Diagnostics.Debug.WriteLine($"❌ Nombre no encontrado en BD para ID {idPrenda}");
                return null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 Error en búsqueda rápida de nombre: {ex.Message}");
                return null;
            }
        }

        // 🔹 MÉTODO NUEVO: MANEJAR CUANDO NO SE ENCUENTRA LA PRENDA
        private void ManejarPrendaNoEncontrada()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔄 Manejando prenda no encontrada ID: {LineaSeleccionada.idPrenda}");

                // Mostrar mensaje informativo
                MostrarMensaje($"⚠ No se pudo encontrar información completa de la prenda con ID: {LineaSeleccionada.idPrenda}. " +
                              $"Se mostrarán los datos básicos de la línea.", "info");

                // Establecer valores por defecto
                txtNombrePrenda.Text = $"Prenda ID: {LineaSeleccionada.idPrenda}";
                NombrePrendaSeleccionada = txtNombrePrenda.Text;

                // Crear información básica
                var infoBasica = new PrendaInfo
                {
                    Tipo = "Desconocido",
                    Nombre = $"Prenda ID: {LineaSeleccionada.idPrenda}"
                };

                // Mostrar información básica
                MostrarInfoPrendaEncontrada(infoBasica);

                System.Diagnostics.Debug.WriteLine($"✅ Configurados valores por defecto para prenda no encontrada");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 Error manejando prenda no encontrada: {ex.Message}");
            }
        }



        // 🔹 MÉTODO SIMPLE - SIN CONFIGURACIONES COMPLEJAS
        private PrendaViewModel BuscarPrendaPorIdSimple(int idPrenda, string tipoPrenda)
        {
            try
            {
                switch (tipoPrenda)
                {
                    case "Blusa":
                        var blusaWS = new PackagePrendas.BlusaWSClient();
                        var blusa = blusaWS.obtenerBlusaPorId(idPrenda);
                        return EsPrendaValida(blusa) ?
                            new PrendaViewModel { Id = blusa.idPrenda, Nombre = blusa.nombre, Tipo = "Blusa" } : null;

                    case "Casaca":
                        var casacaWS = new PackagePrendas.CasacaWSClient();
                        var casaca = casacaWS.obtenerCasacaPorId(idPrenda);
                        return EsPrendaValida(casaca) ?
                            new PrendaViewModel { Id = casaca.idPrenda, Nombre = casaca.nombre, Tipo = "Casaca" } : null;

                    case "Falda":
                        var faldaWS = new PackagePrendas.FaldaWSClient();
                        var falda = faldaWS.obtenerFaldaPorId(idPrenda);
                        return EsPrendaValida(falda) ?
                            new PrendaViewModel { Id = falda.idPrenda, Nombre = falda.nombre, Tipo = "Falda" } : null;

                    case "Gorro":
                        var gorroWS = new PackagePrendas.GorroWSClient();
                        var gorro = gorroWS.obtenerGorroPorId(idPrenda);
                        return EsPrendaValida(gorro) ?
                            new PrendaViewModel { Id = gorro.idPrenda, Nombre = gorro.nombre, Tipo = "Gorro" } : null;

                    case "Pantalon":
                        var pantalonWS = new PackagePrendas.PantalonWSClient();
                        var pantalon = pantalonWS.obtenerPantalonPorId(idPrenda);
                        return EsPrendaValida(pantalon) ?
                            new PrendaViewModel { Id = pantalon.idPrenda, Nombre = pantalon.nombre, Tipo = "Pantalon" } : null;

                    case "Polo":
                        var poloWS = new PackagePrendas.PoloWSClient();
                        var polo = poloWS.obtenerPoloPorId(idPrenda);
                        return EsPrendaValida(polo) ?
                            new PrendaViewModel { Id = polo.idPrenda, Nombre = polo.nombre, Tipo = "Polo" } : null;

                    case "Vestido":
                        var vestidoWS = new PackagePrendas.VestidoWSClient();
                        var vestido = vestidoWS.obtenerVestidoPorId(idPrenda);
                        return EsPrendaValida(vestido) ?
                            new PrendaViewModel { Id = vestido.idPrenda, Nombre = vestido.nombre, Tipo = "Vestido" } : null;

                    default:
                        return null;
                }
            }
            catch (Exception ex)
            {
                // 🔹 CAPTURAR Y REGISTRAR, PERO NO PROPAGAR LA EXCEPCIÓN
                System.Diagnostics.Debug.WriteLine($"    🚫 Excepción en {tipoPrenda}: {ex.GetType().Name} - {ex.Message}");
                return null;
            }
        }



        // 🔹 MÉTODO SIMPLIFICADO: BÚSQUEDA EFICIENTE
        private PrendaInfo BuscarInfoPrendaEficiente(int idPrenda)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🎯 BÚSQUEDA EFICIENTE para ID: {idPrenda}");

                // 🔹 LISTA ORDENADA POR PROBABILIDAD
                string[] tipos = { "Polo", "Blusa", "Pantalon", "Casaca", "Vestido", "Falda", "Gorro" };

                foreach (string tipo in tipos)
                {
                    System.Diagnostics.Debug.WriteLine($"  🔍 Probando: {tipo}");

                    try
                    {
                        var prenda = BuscarPrendaPorId(idPrenda, tipo);
                        if (prenda != null)
                        {
                            System.Diagnostics.Debug.WriteLine($"  ✅ ENCONTRADO en {tipo}: {prenda.Nombre}");
                            return new PrendaInfo { Tipo = tipo, Nombre = prenda.Nombre };
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"  ⚠️ Error en {tipo}: {ex.Message}");
                        continue;
                    }
                }

                System.Diagnostics.Debug.WriteLine($"  ❌ NO ENCONTRADO en ningún tipo");
                return new PrendaInfo { Tipo = "Desconocido", Nombre = $"Prenda ID: {idPrenda}" };
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en búsqueda eficiente: {ex.Message}");
                return new PrendaInfo { Tipo = "Desconocido", Nombre = $"Prenda ID: {idPrenda}" };
            }
        }

        // 🔹 MÉTODO DE RESPUESTA: BÚSQUEDA DIRECTA EN BD
        private PrendaInfo BusquedaDirectaEnBD(int idPrenda)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔄 INTENTANDO BÚSQUEDA DIRECTA EN BD para ID: {idPrenda}");

                // Aquí podrías implementar una consulta directa a la base de datos
                // o usar un servicio web genérico si tienes uno

                System.Diagnostics.Debug.WriteLine($"❌ Búsqueda directa no implementada");
                return null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 Error en búsqueda directa: {ex.Message}");
                return null;
            }
        }

        // 🔹 MÉTODO DE DIAGNÓSTICO PARA PROBAR LA CONEXIÓN
        private void ProbarConexionServicios()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("=== PRUEBA DE CONEXIÓN A SERVICIOS ===");

                string[] tipos = { "Blusa", "Casaca", "Falda", "Gorro", "Pantalon", "Polo", "Vestido" };

                foreach (string tipo in tipos)
                {
                    try
                    {
                        System.Diagnostics.Debug.WriteLine($"🔍 Probando servicio {tipo}...");

                        switch (tipo)
                        {
                            case "Blusa":
                                var blusaWS = new PackagePrendas.BlusaWSClient();
                                var blusas = blusaWS.listarBlusas();
                                System.Diagnostics.Debug.WriteLine($"✅ Servicio Blusa conectado. Blusas: {blusas?.Length ?? 0}");
                                break;
                            case "Casaca":
                                var casacaWS = new PackagePrendas.CasacaWSClient();
                                var casacas = casacaWS.listarCasacas();
                                System.Diagnostics.Debug.WriteLine($"✅ Servicio Casaca conectado. Casacas: {casacas?.Length ?? 0}");
                                break;
                                // ... agregar los demás tipos
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"❌ Error en servicio {tipo}: {ex.Message}");
                    }
                }

                System.Diagnostics.Debug.WriteLine("=== FIN PRUEBA DE CONEXIÓN ===");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 Error en prueba de conexión: {ex.Message}");
            }
        }


        // 🔹 NUEVO: ViewModel para Lotes
        public class LoteViewModel
        {
            public int Id { get; set; }
            public string Descripcion { get; set; }
            public string Almacen { get; set; }
            public string Activo { get; set; }
        }


        // 🔹 MÉTODO PARA ABRIR MODAL DE LOTE - CORREGIR ERROR DE COMPILACIÓN
        protected void btnAbrirModalLote_Click(object sender, EventArgs e)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("INICIANDO btnAbrirModalLote_Click");

                // 1. Cargar datos en el GridView
                CargarLotesEnModal();

                // 2. VERIFICACIÓN ADICIONAL - Debug del GridView
                System.Diagnostics.Debug.WriteLine($"GridView rows después de cargar: {gvLotes.Rows.Count}");
                System.Diagnostics.Debug.WriteLine($"GridView tiene datos: {gvLotes.DataSource != null}");

                // 3. Actualizar el UpdatePanel
                UpdatePanel1.Update();
                System.Diagnostics.Debug.WriteLine("UpdatePanel actualizado");

                // 4. Mostrar el modal - SCRIPT MEJORADO Y CORREGIDO
                string script = @"
        console.log('EJECUTANDO SCRIPT PARA MODAL DE LOTE...');
        
        // Forzar la visualización del modal
        var modalElement = document.getElementById('modalSeleccionarLote');
        if (modalElement) {
            console.log('Modal encontrado, mostrando...');
            var modal = new bootstrap.Modal(modalElement);
            modal.show();
            
            // Verificar si el grid tiene datos
            var gridView = document.getElementById('" + gvLotes.ClientID + @"');
            if (gridView) {
                console.log('GridView encontrado en el DOM');
                var rows = gridView.getElementsByTagName('tr');
                console.log('Filas en el GridView: ' + (rows.length - 1)); // -1 para el header
            }
        } else {
            console.error('No se pudo encontrar el modal de lote');
            alert('Error: No se puede abrir el selector de lotes.');
        }
    ";

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModalLote", script, true);
                System.Diagnostics.Debug.WriteLine("Script para mostrar modal de lote registrado");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"ERROR en btnAbrirModalLote_Click: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"StackTrace: {ex.StackTrace}");
                MostrarMensaje($"Error al abrir selector de lotes: {ex.Message}", "error");
            }
        }



        // 🔹 NUEVO: Cargar lotes en el modal
        // 🔹 MÉTODO CORREGIDO: Cargar lotes en el modal
        private void CargarLotesEnModal()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("INICIANDO CargarLotesEnModal...");

                var loteWS = new PackageAlmacen.LoteWSClient();
                var lotes = loteWS.listarLotesActivos();

                if (lotes == null)
                {
                    System.Diagnostics.Debug.WriteLine("La lista de lotes es NULL");
                    MostrarMensaje("Error: No se pudieron cargar los lotes.", "error");
                    return;
                }

                System.Diagnostics.Debug.WriteLine($"Se encontraron {lotes.Length} lotes del servicio web");

                var lotesList = new List<LoteViewModel>();

                foreach (var lote in lotes)
                {
                    if (lote != null && lote.activo)
                    {
                        lotesList.Add(new LoteViewModel
                        {
                            Id = lote.idLote,
                            Descripcion = lote.descripcion ?? "Sin descripción",
                            Almacen = lote.datAlmacen?.id.ToString() ?? "N/A",
                            Activo = lote.activo ? "Activo" : "Inactivo"
                        });
                    }
                }

                System.Diagnostics.Debug.WriteLine($"{lotesList.Count} lotes activos después del filtro");

                if (lotesList.Count == 0)
                {
                    MostrarMensaje("No se encontraron lotes activos.", "info");
                    System.Diagnostics.Debug.WriteLine("No hay lotes activos para mostrar");
                }

                // ASIGNACIÓN CORRECTA AL GRIDVIEW
                gvLotes.DataSource = lotesList;
                gvLotes.DataBind();

                System.Diagnostics.Debug.WriteLine($"GridView de lotes cargado con {lotesList.Count} registros");

                // VERIFICAR SI EL GRIDVIEW TIENE DATOS DESPUÉS DEL DATABIND
                System.Diagnostics.Debug.WriteLine($"GridView rows después de DataBind: {gvLotes.Rows.Count}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"ERROR en CargarLotesEnModal: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"StackTrace: {ex.StackTrace}");
                MostrarMensaje($"Error al cargar lotes: {ex.Message}", "error");
            }
        }
        // 🔹 NUEVO: Seleccionar lote desde el modal
        // 🔹 CORREGIR: En el método gvLotes_RowCommand
        protected void gvLotes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarLote")
            {
                string[] argumentos = e.CommandArgument.ToString().Split('|');
                if (argumentos.Length >= 2)
                {
                    int idLote = int.Parse(argumentos[0]);
                    string descripcionLote = argumentos[1];

                    // 🔹 CAMBIO: Mostrar SOLO el ID del lote en el TextBox
                    txtIDLote.Text = idLote.ToString(); // Solo el ID
                    hdnIdLote.Value = idLote.ToString(); // El ID real

                    System.Diagnostics.Debug.WriteLine($"✅ Lote seleccionado - ID: {idLote}");

                    // CERRAR MODAL
                    string cerrarScript = @"
                console.log('Cerrando modal de lote...');
                if (typeof cerrarModalLote === 'function') {
                    cerrarModalLote();
                } else {
                    console.error('Función cerrarModalLote no encontrada');
                    // Fallback manual
                    var modalElement = document.getElementById('modalSeleccionarLote');
                    if (modalElement) {
                        modalElement.style.display = 'none';
                        modalElement.classList.remove('show');
                        var backdrops = document.querySelectorAll('.modal-backdrop');
                        backdrops.forEach(function(backdrop) {
                            backdrop.remove();
                        });
                        document.body.classList.remove('modal-open');
                        document.body.style.paddingRight = '';
                        console.log('Modal de lote cerrado manualmente');
                    }
                }
            ";

                    ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModalLote", cerrarScript, true);

                    // ACTUALIZAR UPDATE PANEL
                    UpdatePanel1.Update();

                    MostrarMensaje($"Lote seleccionado: ID {idLote}", "exito");
                }
            }
        }

        // 🔹 NUEVO: Buscar información del lote
        private LoteViewModel BuscarInfoLote(int idLote)
        {
            try
            {
                var loteWS = new PackageAlmacen.LoteWSClient();
                var lote = loteWS.obtenerLotePorID(idLote);

                if (lote != null)
                {
                    return new LoteViewModel
                    {
                        Id = lote.idLote,
                        Descripcion = lote.descripcion ?? "Sin descripción",
                        Almacen = lote.datAlmacen?.id.ToString() ?? "N/A",
                        Activo = lote.activo ? "Activo" : "Inactivo"
                    };
                }
                return null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 Error buscando lote ID {idLote}: {ex.Message}");
                return null;
            }
        }

        

        #endregion
    }

    // 🔹 CLASE AUXILIAR PARA INFORMACIÓN DE PRENDA
    public class PrendaInfo
    {
        public string Tipo { get; set; }
        public string Nombre { get; set; }
    }

    // 🔹 CLASE VIEWMODEL PARA PRENDAS
    public class PrendaViewModel
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Color { get; set; }
        public string Material { get; set; }
        public double PrecioMayor { get; set; }
        public string Tipo { get; set; }

        public string InfoCompleta => $"{Nombre} - {Color} - {Material}";
        public string PrecioFormateado => $"S/ {PrecioMayor:0.00}";
    }
}