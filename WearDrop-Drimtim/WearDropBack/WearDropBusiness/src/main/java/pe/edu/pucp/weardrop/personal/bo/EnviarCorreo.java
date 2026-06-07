package pe.edu.pucp.weardrop.personal.bo;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.InputStream;
import java.io.IOException;
import pe.edu.pucp.weardrop.config.Encriptamiento; // Tu clase AES

public class EnviarCorreo {
    
    private static EnviarCorreo instancia;
    
    private String emailOrigen;
    private String passwordEmailOrigen; 
    private Authenticator autenticador;
    private Properties sessionProperties;
    
    private EnviarCorreo() {
        cargarYConfigurar();
    }
    
    public synchronized static EnviarCorreo getInstance() {
        if (instancia == null) {
            instancia = new EnviarCorreo();
        }
        return instancia;
    }
    
    private void cargarYConfigurar() {
        Properties props = new Properties();
        
        try {
            // -------------------------------------------------------
            // CAMBIO: Ahora leemos TODO de un solo archivo: token.properties
            // -------------------------------------------------------
            try (InputStream input = getClass().getClassLoader().getResourceAsStream("token.properties")) {
                if (input == null) {
                    throw new RuntimeException("No se encontró el archivo token.properties en resources.");
                }
                props.load(input);
            }
            
            // Obtenemos los 3 valores del mismo archivo
            this.emailOrigen = props.getProperty("config.emailOrigen");
            String passEncriptada = props.getProperty("config.passwordEmailOrigen");
            String llaveMail = props.getProperty("mail.encriptacion.llave");
            
            // Validamos que existan
            if (this.emailOrigen == null || passEncriptada == null || llaveMail == null) {
                throw new RuntimeException("Faltan datos en token.properties (email, password o llave).");
            }

            // Desencriptar usando AES
            this.passwordEmailOrigen = Encriptamiento.desencriptar(passEncriptada, llaveMail);
            
            if(this.passwordEmailOrigen == null || this.passwordEmailOrigen.isEmpty()){
                throw new RuntimeException("Error al desencriptar: contraseña vacía.");
            }

            // Configuración SMTP Gmail
            sessionProperties = new Properties();
            sessionProperties.put("mail.smtp.host", "smtp.gmail.com");
            sessionProperties.put("mail.smtp.port", "587");
            sessionProperties.put("mail.smtp.auth", "true");
            sessionProperties.put("mail.smtp.starttls.enable", "true");
            sessionProperties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
            sessionProperties.put("mail.smtp.ssl.protocols", "TLSv1.2");
            
            autenticador = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(emailOrigen, passwordEmailOrigen);
                }
            };
            
        } catch (Exception e) {
            System.err.println("Error cargando configuración de correo: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public boolean enviarCorreoRecuperacion(String destinatario, String token, String nombreUsuario) {
        try {
            Session session = Session.getInstance(sessionProperties, autenticador);
            MimeMessage correo = new MimeMessage(session);
            correo.setFrom(new InternetAddress(emailOrigen, "WearDrop Soporte"));
            correo.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            correo.setSubject("Recuperación de Contraseña - WearDrop");
            correo.setSentDate(new java.util.Date());
            
            String contenidoHtml = generarPlantillaHTML(token, nombreUsuario);
            
            MimeBodyPart cuerpoHtml = new MimeBodyPart();
            cuerpoHtml.setContent(contenidoHtml, "text/html; charset=utf-8");
            
            Multipart contenidoCorreo = new MimeMultipart();
            contenidoCorreo.addBodyPart(cuerpoHtml);
            correo.setContent(contenidoCorreo);
            
            Transport.send(correo);
            System.out.println("✔ Correo enviado a: " + destinatario);
            return true;
            
        } catch (Exception e) {
            System.err.println("✘ Error enviando correo: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
private String generarPlantillaHTML(String token, String nombreUsuario) {
        // URL corregida apuntando al puerto del Frontend (C#)
        String url = "http://localhost:52104/RecuperarContrasena.aspx?token=" + token;
        
        StringBuilder sb = new StringBuilder();

        sb.append("<!DOCTYPE html>");
        sb.append("<html lang='es'>");
        sb.append("<head>");
        sb.append("<meta charset='UTF-8'>");
        sb.append("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        sb.append("<title>Restablecer Contraseña</title>");
        sb.append("</head>");
        sb.append("<body style='margin: 0; padding: 0; font-family: \"Segoe UI\", Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f7;'>");
        
        // --- CONTENEDOR PRINCIPAL ---
        sb.append("<table role='presentation' border='0' cellpadding='0' cellspacing='0' width='100%'>");
        sb.append("<tr>");
        sb.append("<td align='center' style='padding: 40px 0;'>");
        
        // --- TARJETA CENTRAL ---
        sb.append("<table role='presentation' border='0' cellpadding='0' cellspacing='0' width='600' style='background-color: #ffffff; border-radius: 16px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border: 1px solid #e0e0e0;'>");
        
        // 1. CABECERA CON GRADIENTE Y LOGO
        sb.append("<tr>");
        sb.append("<td style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px; text-align: center;'>");
        // Ícono de Candado (Unicode estilizado para máxima compatibilidad)
        sb.append("<div style='font-size: 50px; margin-bottom: 10px;'>🔒</div>");
        sb.append("<h1 style='color: #ffffff; margin: 0; font-size: 28px; font-weight: 700; letter-spacing: 1px;'>WearDrop</h1>");
        sb.append("<p style='color: rgba(255,255,255,0.9); font-size: 14px; margin-top: 5px;'>Seguridad de la Cuenta</p>");
        sb.append("</td>");
        sb.append("</tr>");
        
        // 2. CUERPO DEL MENSAJE
        sb.append("<tr>");
        sb.append("<td style='padding: 40px 30px;'>");
        sb.append("<h2 style='color: #1f2d3a; font-size: 22px; margin-top: 0; font-weight: 600;'>Hola, ").append(nombreUsuario).append("</h2>");
        sb.append("<p style='color: #555555; font-size: 16px; line-height: 1.6;'>Hemos recibido una solicitud para restablecer la contraseña de tu cuenta. Entendemos que estas cosas pasan, ¡vamos a solucionarlo!</p>");
        sb.append("<p style='color: #555555; font-size: 16px; line-height: 1.6;'>Haz clic en el botón de abajo para crear una nueva contraseña segura:</p>");
        
        // BOTÓN DE ACCIÓN
        sb.append("<table role='presentation' border='0' cellpadding='0' cellspacing='0' width='100%'>");
        sb.append("<tr>");
        sb.append("<td align='center' style='padding: 30px 0;'>");
        sb.append("<a href='").append(url).append("' style='display: inline-block; padding: 15px 35px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #ffffff; text-decoration: none; border-radius: 50px; font-weight: bold; font-size: 16px; box-shadow: 0 5px 15px rgba(118, 75, 162, 0.3); border: 1px solid #764ba2;'>Restablecer mi Contraseña</a>");
        sb.append("</td>");
        sb.append("</tr>");
        sb.append("</table>");
        
        // INFORMACIÓN DE SEGURIDAD (Texto pequeño)
        sb.append("<p style='color: #999999; font-size: 13px; margin-top: 20px; border-top: 1px solid #eeeeee; padding-top: 20px;'>");
        sb.append("Si el botón no funciona, copia y pega este enlace en tu navegador:<br>");
        sb.append("<a href='").append(url).append("' style='color: #667eea; text-decoration: none; word-break: break-all;'>").append(url).append("</a>");
        sb.append("</p>");
        
        sb.append("<p style='color: #dc7a73; font-size: 13px; margin-top: 15px;'><strong>Importante:</strong> Este enlace expirará en 1 hora. Si no solicitaste este cambio, puedes ignorar este correo y tu contraseña seguirá siendo la misma.</p>");
        
        sb.append("</td>");
        sb.append("</tr>");
        
        // 3. PIE DE PÁGINA
        sb.append("<tr>");
        sb.append("<td style='background-color: #f8f9fa; padding: 20px; text-align: center; border-top: 1px solid #eeeeee;'>");
        sb.append("<p style='color: #888888; font-size: 12px; margin: 0;'>&copy; 2025 WearDrop Systems.</p>");
        sb.append("<p style='color: #aaaaaa; font-size: 11px; margin: 5px 0 0 0;'>Enviado automáticamente por el sistema de seguridad.</p>");
        sb.append("</td>");
        sb.append("</tr>");
        
        sb.append("</table>"); // Fin Tarjeta
        sb.append("</td>");
        sb.append("</tr>");
        sb.append("</table>"); // Fin Contenedor Principal
        
        sb.append("</body>");
        sb.append("</html>");
        
        return sb.toString();
    }
}