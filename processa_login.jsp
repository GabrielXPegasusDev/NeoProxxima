<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.Driver" %>
<%
    request.setCharacterEncoding("UTF-8");

    String emailDigitado = request.getParameter("email");
    String senhaDigitada = request.getParameter("senha");

    if (emailDigitado != null && senhaDigitada != null) {
        
        String url = "jdbc:mysql://localhost:3306/neoproxxima?useTimezone=true&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
        String usuarioBanco = "root";
        String senhaBanco = "";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, usuarioBanco, senhaBanco);

            String sql = "SELECT * FROM Cliente WHERE Email = ? AND Senha_Hash = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, emailDigitado);
            pstmt.setString(2, senhaDigitada);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                String nomeCliente = rs.getString("Nome_Completo");
                int idCliente = rs.getInt("ID_Cliente");

                session.setAttribute("usuarioLogado", nomeCliente);
                session.setAttribute("idUsuario", idCliente);

                response.sendRedirect("painel.jsp");
            } else {
                // Se não achou, avisa que os dados estão incorretos e volta para a tela de login
                out.println("<script>alert('E-mail ou Senha incorretos!'); history.back();</script>");
            }

        } catch (Exception e) {
            out.println("<script>alert('Erro no login: " + e.getMessage() + "'); history.back();</script>");
            e.printStackTrace();
        } finally {
            // Fecha tudo na ordem inversa
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>