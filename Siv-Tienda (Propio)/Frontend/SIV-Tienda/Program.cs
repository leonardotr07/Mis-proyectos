using SIV_Tienda.Components;
using SIV_Tienda.Services;

var builder = WebApplication.CreateBuilder(args);

// Agrego servicios de Blazor
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

//Registramos el HttpClient
builder.Services.AddScoped(sp => new HttpClient());

//Registro el cliente generado.
builder.Services.AddScoped<ProductoClient>(sp =>
{
    var httpClient = sp.GetRequiredService<HttpClient>();
    var client = new ProductoClient(httpClient);
    //Por ahora sera localhost
    client.BaseUrl = "http://localhost:8090"; 
    return client;
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseWhen(context => !context.Request.Path.StartsWithSegments("/_blazor"), appBuilder =>
{
    appBuilder.UseAntiforgery();
});

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();



app.Run();
