using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.OpenApi.Models;
using System.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Minimal API",
        Version = "v1"
    });
});

// Add CORS services
builder.Services.AddCors();

var app = builder.Build();

// Configure the HTTP request pipeline.
app.UseSwagger();
app.UseSwaggerUI(options =>
{
    options.SwaggerEndpoint("/swagger/v1/swagger.json", "Minimal API v1");
});

app.UseCors(builder =>
    builder.AllowAnyOrigin()
           .AllowAnyMethod()
           .AllowAnyHeader());

string connectionString = "Server=localhost,1433;Database=TFEKSDB;User Id=admin;Password=priyank1912;Encrypt=True;TrustServerCertificate=True;";

app.MapPost("/api/save-user", async (UserDto user) =>
{
    if (string.IsNullOrEmpty(user.Username) || string.IsNullOrEmpty(user.Email))
    {
        return Results.BadRequest("Invalid user data.");
    }

    using var connection = new SqlConnection(connectionString);
    await connection.OpenAsync();

    using var command = connection.CreateCommand();
    command.CommandText = "INSERT INTO dbo.USERS (USERNAME, EMAIL) VALUES (@USERNAME, @EMAIL)";
    command.Parameters.Add(new SqlParameter("@USERNAME", user.Username));
    command.Parameters.Add(new SqlParameter("@EMAIL", user.Email));

    await command.ExecuteNonQueryAsync();

    return Results.Ok("User saved successfully.");
});

app.Run();

record UserDto(string Username, string Email);
