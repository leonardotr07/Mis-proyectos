using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ProveedorWS;

namespace WearDropWA
{
    public partial class GestionarProveedores : System.Web.UI.Page
    {

        private ProveedorWSClient boProveedor;
        private BindingList<proveedor> proveedores;




        // 🔹 Carga inicial
        protected void Page_Load(object sender, EventArgs e)
        {

            boProveedor = new ProveedorWSClient();
            proveedores = new BindingList<proveedor>
                (boProveedor.listarTodosLosProveedores());
            dgvProveedores.DataSource = proveedores;
            dgvProveedores.DataBind();



        }





        protected void dgvProveedores_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Text = DataBinder.Eval(e.Row.DataItem, "idProveedor").ToString();
                e.Row.Cells[1].Text = DataBinder.Eval(e.Row.DataItem, "nombre").ToString();
                e.Row.Cells[2].Text = DataBinder.Eval(e.Row.DataItem, "telefono").ToString();
                e.Row.Cells[3].Text = DataBinder.Eval(e.Row.DataItem, "direccion").ToString();
                e.Row.Cells[4].Text = DataBinder.Eval(e.Row.DataItem, "RUC").ToString();
            }
        }



        // 🔹 Evento de paginación
        protected void dgvProveedores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvProveedores.PageIndex = e.NewPageIndex;
            dgvProveedores.DataBind();
        }

        // 🔹 Click en "Registrar"
        protected void btnRegistrarProveedor_Click(object sender, EventArgs e)
        {
            // Aquí rediriges a la página para registrar un nuevo proveedor
            Response.Redirect("~/RegistrarProveedor.aspx");
        }

        // 🔹 Click en "Modificar" (ícono del lápiz)
        protected void btnModificarProveedor_Click(object sender, EventArgs e)
        {

            int idProveedorr = Int32.Parse(((LinkButton)sender).CommandArgument);
            proveedor proveedorSelect = proveedores.Single(x => x.idProveedor == idProveedorr);
            Session["proveedorSelect"] = proveedorSelect;

            // Redirige con parámetro para editar
            Response.Redirect($"~/RegistrarProveedor.aspx?accion=modificar");
        }

        // 🔹 Click en "Ver" (ícono del ojo)
        protected void btnVerProveedor_Click(object sender, EventArgs e)
        {

            int idProveedorr = Int32.Parse(((LinkButton)sender).CommandArgument);
            proveedor proveedorSelect = proveedores.Single(x => x.idProveedor == idProveedorr);
            Session["proveedorSelect"] = proveedorSelect;

            // Redirige a la página de detalles del proveedor
            Response.Redirect($"~/RegistrarProveedor.aspx?accion=ver");
        }

        // 🔹 (Opcional) Click en "Eliminar"
        protected void btnEliminarProveedor_Click(object sender, EventArgs e)
        {


            int idProveedorr = Int32.Parse(((LinkButton)sender).CommandArgument);
            boProveedor.eliminarProveedor(idProveedorr);


            Response.Redirect("~/GestionarProveedores.aspx");


        }
    }
}