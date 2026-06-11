<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String nomeUsuario = (String) session.getAttribute("usuarioLogado");
    
    if (nomeUsuario == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>NeoProxxima - Área do Cliente</title>
    <link rel="stylesheet" href="css/styles.css"> </head>
<body>

    <div class="container"> <header>
            <h1>Olá, <%= nomeUsuario %>!</h1>
            <p>Bem-vindo à sua Área Exclusiva NeoProxxima</p>
        </header>

        <main class="painel-dados">
            <h2>Seus Dados Cadastrais</h2>
            <div class="card-dados">
                <p><strong>Nome:</strong> <%= nomeUsuario %></p>
                <p><strong>Status do Plano:</strong> <span style="color: #ff0055;">Nenhum plano selecionado</span></p>
            </div>

            <br>
            <a href="logout.jsp" class="btn-connect" style="background: #ff0055;">Sair / Logout</a>
        </main>
    </div>
</body>
</html>