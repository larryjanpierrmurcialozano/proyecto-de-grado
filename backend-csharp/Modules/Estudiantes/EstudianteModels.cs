using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace ProyectoGrado.Api.Modules.Estudiantes;

public sealed record EstudianteRequest
{
    [JsonPropertyName("documento"), Required]
    public required string Documento { get; init; }

    [JsonPropertyName("nombre"), Required]
    public required string Nombre { get; init; }

    [JsonPropertyName("apellido"), Required]
    public required string Apellido { get; init; }

    [JsonPropertyName("fecha_nacimiento")]
    public DateOnly? FechaNacimiento { get; init; }

    [JsonPropertyName("genero")]
    public string Genero { get; init; } = "M";

    [JsonPropertyName("id_grupo"), Range(1, int.MaxValue), JsonNumberHandling(JsonNumberHandling.AllowReadingFromString)]
    public int IdGrupo { get; init; }

    [JsonPropertyName("acudiente_nombre")]
    public string? AcudienteNombre { get; init; }

    [JsonPropertyName("acudiente_telefono")]
    public string? AcudienteTelefono { get; init; }

    [JsonPropertyName("correo")]
    public string? Correo { get; init; }

    [JsonPropertyName("direccion")]
    public string? Direccion { get; init; }

    [JsonPropertyName("estado")]
    public string Estado { get; init; } = "Activo";
}
