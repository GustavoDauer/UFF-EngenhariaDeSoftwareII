<%-- 
    Document   : header
    Created on : 13/02/2016, 15:51:39
    Author     : gustavo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/design.css" />
        <title>Banco UFF - Sistema para Caixa Eletrônico versão 1.0</title>
    </head>
    <body> 
        <table cellspacing="0" cellpadding="0" width="100%">
            <tr>
                <td id="menu">
                    <!-- MENU -->
                    <ul>
                        <!-- Usuário -->                
                        <li><a href="consulta_saldo.jsp">Consulta saldo</a></li>
                        <li><a href="consulta_poupanca.jsp">Consulta poupança</a></li>
                        <li><a href="consulta_limite.jsp">Consulta limite</a></li>                
                        <li><a href="deposito_em_conta.jsp">Depósito (TODO)</a></li>
                        <!--<li><a href="deposito_terceiro.jsp">Depósito à terceiro</a></li>                -->
                        <li><a href="saque.jsp">Saque (TODO)</a></li>                                
                        <li><a href="pagamento_autenticado.jsp">Pagamentos (TODO)</a></li>                
                    </ul>
                    <br />
                    <ul>
                        <!-- Gerência -->                
                        <li><a href="cliente_insert.jsp">Cadastrar Cliente</a></li>
                        <li><a href="ClienteController?command=viewAll">Listar Clientes</a></li>                
                        <li><a href="conta_insert.jsp">Cadastrar Conta</a></li>
                        <li><a href="ContaController?command=viewAll">Listar Contas</a></li>                
                        <li><a href="caixa_insert.jsp">Cadastrar Caixa Eletrônico</a></li>
                        <li><a href="CaixaEletronicoController?command=viewAll">Listar Caixas Eletrônicos</a></li>
                    </ul>
                </td>   
                <td id="conteudo">
                    <!-- CONTEUDO -->
                
                          

