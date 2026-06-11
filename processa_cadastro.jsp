<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.Driver" %>
<%
    request.setCharacterEncoding("UTF-8");

    String nome = request.getParameter("nome");
    String cpf = request.getParameter("cpf");
    String email = request.getParameter("email");
    String senha = request.getParameter("senha"); 

    String url = "jdbc:mysql://localhost:3306/neoproxxima?useTimezone=true&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
    String usuarioBanco = "root";
    String senhaBanco = "";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, usuarioBanco, senhaBanco);

        String sql = "INSERT INTO Cliente (Nome_Completo, CPF, Email, Senha_Hash, ID_Plano) VALUES (?, ?, ?, ?, NULL)";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, nome);
        pstmt.setString(2, cpf);
        pstmt.setString(3, email);
        pstmt.setString(4, senha);

        int linhas = pstmt.executeUpdate();

        if (linhas > 0) {
            response.sendRedirect("painel.jsp"); 
        } else {
            out.println("<script>alert('Não foi possível realizar o cadastro.'); history.back();</script>");
        }

    } catch (Exception e) {
        out.println("<script>alert('Erro no banco: " + e.getMessage() + "'); history.back();</script>");
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>